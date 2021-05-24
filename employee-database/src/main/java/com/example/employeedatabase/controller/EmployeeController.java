package com.example.employeedatabase.controller;

import com.example.employeedatabase.entity.EmployeeEntity;
import com.example.employeedatabase.model.Employee;
import com.example.employeedatabase.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin(origins = "*")
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @RequestMapping(value="getAllEmployees",method = RequestMethod.GET)
    public List<Employee> getAllEmployees(){
        return employeeService.getAllEmployees();
    }

    @RequestMapping(value="addEmployee",method = RequestMethod.POST)
    public String addEmployee(@RequestBody EmployeeEntity employeeEntity){
        return employeeService.addEmployee(employeeEntity);
    }

    @RequestMapping(value = "updateEmployee",method = RequestMethod.PUT)
    public String updateEmployee(@RequestBody EmployeeEntity employeeEntity){
        return employeeService.updateEmployee(employeeEntity);
    }

    @RequestMapping(value = "deleteEmployee",method = RequestMethod.DELETE)
    public String removeEmployee(@RequestBody EmployeeEntity employeeEntity){
        return employeeService.removeEmployee(employeeEntity);
    }
}
