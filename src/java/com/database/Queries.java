/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author DELL
 */
public class Queries {
    private Connection con;
    private String table;
    
    public Queries (Connection con, String table) {
        this.con = con;
        this.table = table;
    }
    
    public ResultSet select (String items, String where) throws SQLException {
        Statement stmt = this.con.createStatement();
        ResultSet res = stmt.executeQuery("SELECT " + items + " FROM " + this.table + " WHERE " + where);
        return res;
    }
    
    public ResultSet selectWithMultipleTables (String items, String where, String tables) throws SQLException {
        Statement stmt = this.con.createStatement();
        ResultSet res = stmt.executeQuery("SELECT " + items + " FROM " + this.table + "," + tables + " WHERE " + where);
        return res;
    }
    
    public int insert (String items, String values) throws SQLException {
        Statement stmt = this.con.createStatement();
        int res = stmt.executeUpdate("INSERT INTO " + this.table + "(" + items + ") VALUES(" + values + ")");
        return res;
    }
    
    public int update (String sets, String where) throws SQLException {
        Statement stmt = this.con.createStatement();
        int res = stmt.executeUpdate("UPDATE " + this.table + " SET " + sets + " WHERE " + where);
        return res;
    }
    
    public int delete (String where) throws SQLException {
        Statement stmt = this.con.createStatement();
        int res = stmt.executeUpdate("DELETE FROM " + this.table + " WHERE + " + where);
        return res;
    }
    
    protected void finalize () throws SQLException{  
       this.con.close();
    }  
}
