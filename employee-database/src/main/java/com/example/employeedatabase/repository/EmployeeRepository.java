package com.example.employeedatabase.repository;

import com.example.employeedatabase.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends JpaRepository<EmployeeEntity,Integer> {

    public boolean existsByFirstNameAndLastName(String firstName,String lastName);

}
