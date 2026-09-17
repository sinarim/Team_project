package com.min.edu.dto;

public class ProfileDto {

    private String profileId;
    private String userId;
    private String username;
    private String rank;
    private int totalPoints;

    public ProfileDto() {
    }

    public ProfileDto(String profileId, String userId,
                      String username, String rank, int totalPoints) {
        this.profileId = profileId;
        this.userId = userId;
        this.username = username;
        this.rank = rank;
        this.totalPoints = totalPoints;
    }

    public String getProfileId() {
        return profileId;
    }

    public void setProfileId(String profileId) {
        this.profileId = profileId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public int getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(int totalPoints) {
        this.totalPoints = totalPoints;
    }
}