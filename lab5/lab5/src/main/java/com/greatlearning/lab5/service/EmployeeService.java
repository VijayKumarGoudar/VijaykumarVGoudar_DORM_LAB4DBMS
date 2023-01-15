package com.greatlearning.lab5.service;

import com.greatlearning.lab5.entity.Employee;
import com.greatlearning.lab5.repository.EmployeeRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeRepo employeeRepo;

    public List<Employee> getEmployees() {
        return employeeRepo.findAll();
    }

    public void createEmployee(Employee employee) {
        employeeRepo.save(employee);
    }

    public Employee getEmployee(long id) {
        return employeeRepo.findById(id)
                           .orElse(null);
    }

    public void deleteEmployee(long id) {
        employeeRepo.deleteById(id);
    }
}
