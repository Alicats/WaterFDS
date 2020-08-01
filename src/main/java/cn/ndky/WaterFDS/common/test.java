package cn.ndky.WaterFDS.common;

import org.apache.shiro.crypto.hash.SimpleHash;

public class test {
    public static void main(String[] args) {
        String pws = new SimpleHash("MD5","123","col1",1024).toString();
        System.out.println(pws);
    }
}
