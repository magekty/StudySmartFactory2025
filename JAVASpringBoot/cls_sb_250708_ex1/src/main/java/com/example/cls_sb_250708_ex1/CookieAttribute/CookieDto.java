package com.example.cls_sb_250708_ex1.CookieAttribute;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CookieDto {
    private String name;
    private String value;
    private String path;
    private int maxAge;
}
