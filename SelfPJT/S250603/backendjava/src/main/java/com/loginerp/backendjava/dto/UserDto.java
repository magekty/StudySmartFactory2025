// src/main/java/com/yourcompany/appname/dto/UserDto.java (Data Transfer Object)
package com.loginerp.backendjava.dto;

import lombok.Data;

@Data // Lombok
public class UserDto {
    private Integer UserId;
    private String Username;
    private String Password;
    private String Email;
}