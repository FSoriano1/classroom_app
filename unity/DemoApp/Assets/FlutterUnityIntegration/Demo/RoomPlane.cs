using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoomPlane
{
    public GameObject obj;
    public bool selected;
    public bool moving;
    public Vector3 storedPos;
    public bool wall;
    public bool horiz;

    public RoomPlane(GameObject obj, bool wall, bool horiz){
        this.obj = obj;
        this.wall = wall;
        this.horiz = horiz;
        moving = false;
        selected = false;
        storedPos = obj.transform.position;
    }

    public GameObject getObj(){
        return obj;
    }

    public bool getSelected(){
        return selected;
    }

    public bool getMoving(){
        return moving;
    }

    public void changeSelected(bool s){
        selected = s;
    }

    public void changeMoving(bool m){
        moving = m;
    }

    public void setStoredPos(Vector3 pos){
        storedPos = pos;
    }

    public Vector3 getStoredPos(){
        return storedPos;
    }

    public bool getWall(){
        return wall;
    }

    public bool getHoriz(){
        return horiz;
    }

}
