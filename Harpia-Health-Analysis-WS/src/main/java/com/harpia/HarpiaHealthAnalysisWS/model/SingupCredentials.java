package com.harpia.HarpiaHealthAnalysisWS.model;

public class SingupCredentials {
    String Username;
    String password;

    public SingupCredentials(String username, String password) {
        Username = username;
        this.password = password;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
