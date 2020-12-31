/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.database;

import com.mysql.jdbc.Connection;
import java.sql.*;

/**
 *
 * @author DELL
 */
public class DatabaseConnection {
    private String url;
    private String username;
    private String password;
    
    public DatabaseConnection() {
        this.url = "jdbc:mysql://localhost:3307/office_hours_reservation";
        this.username = "root";
        this.password = "HelloInstaller90@";
    }

    public DatabaseConnection(String url, String username, String password) {
        this.url = url;
        this.username = username;
        this.password = password;
    }
    
    public Connection connect () throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
        try {            
            Class.forName("com.mysql.jdbc.Driver").newInstance();  
            Connection con=(Connection) DriverManager.getConnection(this.url, this.username, this.password);
            return con;

        } catch (Exception cnfe) {
            System.err.println("Exception: " + cnfe);
        }
        
        return null;
    }
}
