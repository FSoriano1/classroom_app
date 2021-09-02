using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Furniture
{
    public GameObject obj;
    public int type;
    public Vector3 storedPos;
    public Quaternion storedRot;
    public bool selected;
    public Vector3 currentPos;

    public bool moving;
    public bool rotating;
    public bool recentPressed;

    public Furniture(GameObject obj, int type){
        this.obj = obj;
        this.type = type;
        this.storedPos = obj.transform.position;
        this.storedRot = obj.transform.rotation;
        this.selected = false;
        moving = false;
        rotating = false;
        recentPressed = false;
        
    }

    public GameObject getObj(){
        return obj;
    }

    public Vector3 getStoredPos(){
        return storedPos;
    }

    public void setStoredPos(Vector3 pos){
        storedPos = pos;
    }

    public Quaternion getStoredRot(){
        return storedRot;
    }
    
    public void setStoredRot(Quaternion rot){
        storedRot = rot;
    }

    public bool getRecentPressed(){
        return recentPressed;
    }

    public void setRecentPressed(bool p){
        recentPressed = p;
    }

    public bool getSelected(){
        return selected;
    }

    public bool getMoving(){
        return moving;
    }
    public bool getRotating(){
        return rotating;
    }

    public void changeSelected(bool s){
        selected = s;
    }

    public void changeMoving(bool m){
        moving = m;
    }
    public void changeRotating(bool r){
        rotating = r;
    }
}
