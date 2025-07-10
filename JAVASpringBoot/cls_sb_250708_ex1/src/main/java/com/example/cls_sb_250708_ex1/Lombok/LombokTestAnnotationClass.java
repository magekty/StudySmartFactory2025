package com.example.cls_sb_250708_ex1.Lombok;

import lombok.*;

// case1 Getter+Setter
/*@Setter
@Getter
public class LombokTestAnnotationClass {
    String name;
    String name2;
}

class TestLombokTestAnnotationClass {
    public TestLombokTestAnnotationClass() {
        LombokTestAnnotationClass t = new LombokTestAnnotationClass();
        t.getName();
        t.getName2();
        t.setName("홍길동");
    }
}*/

// case2 NoArgsConstructor+AllArgsConstructor
/*
@NoArgsConstructor
@AllArgsConstructor
public class LombokTestAnnotationClass {
    String name2;
    String name;
//    public LombokTestAnnotationClass(String name) {
//        this.name = name;
//    }
}

class TestLombokTestAnnotationClass {
    public TestLombokTestAnnotationClass() {
        LombokTestAnnotationClass t = new LombokTestAnnotationClass("김태영");
        LombokTestAnnotationClass t1 = new LombokTestAnnotationClass();
    }
}*/

// case3 RequiredArgsConstructor
/*@RequiredArgsConstructor
public class LombokTestAnnotationClass {
    private final String name;
    @NonNull
    private String role;
}

class TestLombokTestAnnotationClass {
    public TestLombokTestAnnotationClass() {
        LombokTestAnnotationClass t = new LombokTestAnnotationClass("김태영", "개발자");
    }
}*/

