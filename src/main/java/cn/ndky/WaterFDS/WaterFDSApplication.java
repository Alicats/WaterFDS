package cn.ndky.WaterFDS;


import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("cn.ndky.WaterFDS.mapper")
public class WaterFDSApplication {

    public static void main(String[] args) {
        SpringApplication.run(WaterFDSApplication.class, args);
    }
}
