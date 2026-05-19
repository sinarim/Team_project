package com.min.edu.dto;

public class ProblemDto {
    private String problemId;
    private String title;
    private String content;
    private String initialCode;
    private String type;
    private int difficulty;
    private String category;
    private String source;

    // 기본 생성자
    public ProblemDto() {}

    // Getter / Setter
    public String getProblemId() { return problemId; }
    public void setProblemId(String problemId) { this.problemId = problemId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getInitialCode() { return initialCode; }
    public void setInitialCode(String initialCode) { this.initialCode = initialCode; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public int getDifficulty() { return difficulty; }
    public void setDifficulty(int difficulty) { this.difficulty = difficulty; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }
}