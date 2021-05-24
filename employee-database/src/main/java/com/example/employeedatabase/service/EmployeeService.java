package com.example.employeedatabase.service;

import com.example.employeedatabase.entity.EmployeeEntity;
import com.example.employeedatabase.model.Employee;
import com.example.employeedatabase.repository.EmployeeRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeRepository employeeRepository;

    public List<Employee> getAllEmployees(){
        try{
            List<EmployeeEntity> employees=employeeRepository.findAll();
            List<Employee> customEmployees=new ArrayList<>();
            employees.stream().forEach(e->{
                Employee employee=new Employee();
                BeanUtils.copyProperties(e,employee);
                customEmployees.add(employee);
            });
            return customEmployees;

        }catch (Exception ex){
            throw ex;
        }
    }

    public String addEmployee(EmployeeEntity employee){
        try {
            if(!employeeRepository.existsByFirstNameAndLastName(employee.getFirstName(),employee.getLastName())){
                employeeRepository.save(employee);
                return "Saved!";
            }else{
                return "This employee already exists!";
            }
        }catch (Exception e){
            throw e;
        }
    }

    public String removeEmployee(EmployeeEntity employee) {
        try {
            if (employeeRepository.existsByFirstNameAndLastName(employee.getFirstName(), employee.getLastName())) {
                employeeRepository.delete(employee);
                return "Deleted!";
            } else {
                return "Employee does not exists";
            }
        } catch (Exception e) {
            throw e;
        }
    }

    public String updateEmployee(EmployeeEntity employee){
        try {
            if(employeeRepository.existsById(employee.getId())){
                employeeRepository.save(employee);
                return "Updated!";
            }else {
                return "Employee does not exists";
            }
        }catch (Exception e){
            throw  e;
        }
    }
}
