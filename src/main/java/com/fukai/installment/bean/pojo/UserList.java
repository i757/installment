package com.fukai.installment.bean.pojo;

/**
 * @Author: luoxiaozhu
 * @Date: 2019-02-26 19:10
 */
public class UserList {
    private String name;
    private String mobilePhone;
    private String idCard;
    private double installmentAmount;
    private String installmentEntityId;
    private double interestRate;

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getIdCard() {
        return idCard;
    }

    public void setIdCard(String idCard) {
        this.idCard = idCard;
    }

    public double getInstallmentAmount() {
        return installmentAmount;
    }

    public void setInstallmentAmount(double installmentAmount) {
        this.installmentAmount = installmentAmount;
    }

    public String getInstallmentEntityId() {
        return installmentEntityId;
    }

    public void setInstallmentEntityId(String installmentEntityId) {
        this.installmentEntityId = installmentEntityId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }
}
