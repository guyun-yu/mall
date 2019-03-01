package com.situ.mall.sys.model;

import com.situ.base.FormatPage;

public class UserModel extends FormatPage {

    private String password;
    private String sex;
    private String birthday;
    private String role;
    private String phone;

    public UserModel() {
        super();
    }

    public UserModel(String code, String name, String password, String role) {
        super(code, name);
        this.password = password;
        this.role = role;
    }

    @Override
    public String toString() {
        return "UserModel [password=" + password + ", sex=" + sex + ", birthday=" + birthday + ", role=" + role
                + ", phone=" + phone + "]";
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

}
