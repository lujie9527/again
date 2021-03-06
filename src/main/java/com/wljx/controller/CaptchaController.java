package com.wljx.controller;


import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;

@Controller
@RequestMapping("/captcha")
public class CaptchaController {
    @Autowired
    private Producer captchaProducer;
    @RequestMapping("/code")
    public ModelAndView getCaptchaCode(HttpServletRequest request, HttpServletResponse response) throws IOException{
        HttpSession session = request.getSession();
        
        response.setDateHeader("Expires", 0);  
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
        response.setHeader("Pragma", "no-cache");  
        response.setContentType("image/jpeg"); 
        
        //生成验证码文本
        String capText = captchaProducer.createText();  
        session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);
        System.out.println("生成验证码文本===="+capText);
        //利用生成的字符串构建图片
        BufferedImage bi = captchaProducer.createImage(capText);
        ServletOutputStream out = response.getOutputStream();  
        ImageIO.write(bi, "jpg", out);  
        
        try {  
            out.flush();  
        } finally {  
            out.close();  
        }
        return null;
    }
    
}