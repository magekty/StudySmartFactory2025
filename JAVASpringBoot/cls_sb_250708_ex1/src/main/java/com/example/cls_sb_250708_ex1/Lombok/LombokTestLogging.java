package com.example.cls_sb_250708_ex1.Lombok;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
public class LombokTestLogging {
    @GetMapping("/log")
    public String logTest() {
        log.info("내부 info 출력");
        log.debug("내부 debug 출력");
        log.error("내부 error 출력");
        return "로그를 출력 했어요";
    }
}
