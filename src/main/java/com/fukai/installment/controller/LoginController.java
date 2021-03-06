package com.fukai.installment.controller;

import com.fukai.installment.bean.InstallmentEntity;
import com.fukai.installment.bean.User;
import com.fukai.installment.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author: luoxiaozhu
 * @Date: 2019-02-21 21:51
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public Object login(HttpServletRequest request, @RequestBody Map<String, String> map){
        String mobilePhone = map.get("mobilePhone");
        String password = map.get("password");
        User user = userService.findByMobilePhoneAndPassword(mobilePhone,password);
        Map<String,Object> objectMap = new HashMap<>();
        if(user != null){
            if(!user.getUserType().equals("1")){
                objectMap.put("error","手机号或密码错误");
            }else {
                objectMap.put("success","success");
                objectMap.put("user",user);
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(8*60*60);
                session.setAttribute("userId",user.getId());
            }

        }else{
            objectMap.put("error","手机号或密码错误");
        }
        return objectMap;
    }

    @RequestMapping(value = "/login4app",method = RequestMethod.POST)
    @ResponseBody
    public Object login4App(@RequestBody Map<String, String> map){
        String mobilePhone = map.get("mobilePhone");
        String password = map.get("password");
        User user = userService.findByMobilePhoneAndPassword(mobilePhone,password);
        Map<String,Object> objectMap = new HashMap<>();
        if(user != null){
            objectMap.put("success","success");
            objectMap.put("user",user);
        }else{
            objectMap.put("error","手机号或密码错误");
        }
        return objectMap;
    }

    @RequestMapping("/success")
    public String success(){
        return "success";
    }

    @RequestMapping("/deatil")
    public String deatil(Model model,String id){
        model.addAttribute("infoId",id);
        return "article_detail";
    }

    @RequestMapping("/addUser")
    public String addUser(){
        return "addUser";
    }
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("userId");
        return "redirect:/success";
    }

    @RequestMapping("/modify_password")
    public String modifyPassword(){
        return "modify_password";
    }

    @RequestMapping("/edit")
    public String edit(Model model,String id){
        InstallmentEntity installmentEntity = userService.findOne(id);
        User user = userService.queryUser(installmentEntity.getUserId());
        model.addAttribute("user",user);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        installmentEntity.setRepayDate1(format.format(installmentEntity.getRepayDate()));
        model.addAttribute("installmentEntity",installmentEntity);
        return "modifyUser";
    }

}
