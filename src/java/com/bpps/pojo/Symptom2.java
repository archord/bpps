package com.bpps.pojo;
// Generated 2012-5-19 11:30:03 by Hibernate Tools 3.2.1.GA

/**
 * Symptom generated by hbm2java
 */
public class Symptom2 implements java.io.Serializable {

    private Symptom symptom;
    private String posName;
    private String parentSymName;

    public Symptom2() {
    }

    public Symptom2(Symptom symptom, String posName) {
        this.symptom = symptom;
        this.posName = posName;
    }

    /**
     * @return the symptom
     */
    public Symptom getSymptom() {
        return symptom;
    }

    /**
     * @param symptom the symptom to set
     */
    public void setSymptom(Symptom symptom) {
        this.symptom = symptom;
    }

    /**
     * @return the posName
     */
    public String getPosName() {
        return posName;
    }

    /**
     * @param posName the posName to set
     */
    public void setPosName(String posName) {
        if(posName==null)
            posName = "";
        this.posName = posName;
    }

    /**
     * @return the parentSymName
     */
    public String getParentSymName() {
        return parentSymName;
    }

    /**
     * @param parentSymName the parentSymName to set
     */
    public void setParentSymName(String parentSymName) {
        if(parentSymName!=null)
            this.parentSymName = parentSymName;
        else
            this.parentSymName = "";
    }
}
