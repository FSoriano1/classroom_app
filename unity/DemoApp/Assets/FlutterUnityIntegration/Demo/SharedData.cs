using System.Collections.Generic;
using UnityEngine;

public class SharedData : MonoBehaviour
{

    private static SharedData _instance;
    public static SharedData Instance {
        get {
            return _instance;
        }
    }

    public List<RoomPlane> planeList;
    public List<Furniture> furnitureList;


    private void Awake()
    {
        if(_instance != null && _instance != this){
            Destroy(this.gameObject);
        }
        else{
            _instance = this;
        }

        DontDestroyOnLoad(this);
    }
 
    public List<RoomPlane> getPlanes(){
        return planeList;
    }

    public List<Furniture> getFurnitures(){
        return furnitureList;
    }
    public void setPlanes(List<RoomPlane> planes){
        planeList = new List<RoomPlane>(planes);
    }

    public void setFurnitures(List<Furniture> furnitures){
        furnitureList = new List<Furniture>(furnitures);
    }

 }
