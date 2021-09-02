using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainManager : MonoBehaviour //corresponds to scene named "MainScene". This is the main editor scene where you can add furniture.
{
    public Camera PZCam;
    public int screenH = Screen.height;
    public int screenW = Screen.width;
    public float roomLength=10;
    public float roomWidth=6;
    static public List<Furniture> furnitureList;
    public PanZoom PZScript;
    public Camera _3DCam;
    public GameObject Cinemachine;
    public GameObject InputManager;
    public Canvas _3DCanvas;
    public GameObject _3DPlayer;
    List<RoomPlane> pList;

    GameObject prefab1;
    GameObject prefab2;
    Vector2 beginTouchPosition;
    private SharedData SharedData;

    bool in3D = false;

    //for newly created projects, the room shape editor will be the first scene. However, if not, this should probably be the first scene.
    void Start()
    {
        SharedData = SharedData.Instance;
        //set public mesh data to what's in the database or from 2D editor, and then instantiate them
        furnitureList = new List<Furniture>();
        pList = new List<RoomPlane>(SharedData.getPlanes());
        foreach(RoomPlane plane in pList){
            plane.getObj().GetComponent<Collider>().enabled = false; //to stop plane colliders from interfering with furniture colliders
            if(plane.getWall()){
                createWall(plane);
            }
        }
        prefab1 = Resources.Load<GameObject>("BigFurniturePack/Prefabs/Sofas&Chairs/chair_2") as GameObject;
        prefab1.transform.localScale = new Vector3(1,1,1);
        prefab1.AddComponent<SphereCollider>();

        furnitureList.Add(new Furniture(Instantiate(prefab1, new Vector3(1,0,1), Quaternion.Euler(270,0,0)), 1)); //just a default chair, probably remove in the future

        //should generate all furniture assets from database into a list, where each index matches id in database.
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.touchCount > 0){//
            Touch touch = Input.GetTouch(0);
            Ray ray = Camera.main.ScreenPointToRay(touch.position);
            RaycastHit hit;
            bool tap = false;
            Vector2 endTouchPosition;
            float speedModifier = 0.005f;

            switch (touch.phase) {
                case TouchPhase.Began:
                    beginTouchPosition = touch.position;
                    break;
                case TouchPhase.Ended:
                    endTouchPosition = touch.position;

                    if(beginTouchPosition == endTouchPosition){
                        tap = true;
                    }
                    else{
                        //It's a swipe!
                    }
                    break;
            }
            
            //If a furniture object is tapped on
            if(tap && Physics.Raycast(ray, out hit) && !(touch.phase==TouchPhase.Moved) && !in3D){
                bool objSelected = false;
                bool objAction = false;
                foreach(Furniture obj in furnitureList){
                    if(obj.getMoving()||obj.getRotating()){
                        objAction = true;
                    }
                }
                if(!objAction){
                    foreach(Furniture obj in furnitureList){ 
                        if(obj.getObj().transform == hit.transform){
                            UnityMessageManager.Instance.SendMessageToFlutter("canvas5");
                            obj.changeSelected(true);
                            objSelected = true;
                        }
                        else{
                            obj.changeSelected(false);
                            obj.changeMoving(false);
                            obj.changeRotating(false);
                        }
                    }
                    if(!objSelected){ //if tapped and plane collider is hit, deselect
                        foreach(Furniture obj in furnitureList){
                            obj.changeSelected(false);
                        }
                        UnityMessageManager.Instance.SendMessageToFlutter("canvas4");
                        PZScript.SelectScript();

  
                    }
                }
            }
            else{ //if tapped and no collider is hit, deselect
                if(tap){
                    foreach(Furniture obj in furnitureList){
                        if(obj.getSelected() && !obj.getMoving()){
                            UnityMessageManager.Instance.SendMessageToFlutter("canvas4");
                            obj.changeSelected(false);
                        }
                    }
                }
            }

            if(touch.phase == TouchPhase.Moved){
                foreach(Furniture obj in furnitureList){
                    //MOVING
                    if(obj.getSelected() && obj.getMoving()){
                        obj.getObj().transform.position = new Vector3(
                            
                            obj.getObj().transform.position.x + touch.deltaPosition.x * speedModifier,
                            obj.getObj().transform.position.y,
                            obj.getObj().transform.position.z + touch.deltaPosition.y * speedModifier
                        );
                        
                    } 
                    //ROTATING, swipe left or right. up or down does not affect it
                    else if(obj.getSelected() && obj.getRotating()){
                        Vector3 localAngle = obj.getObj().transform.localEulerAngles;
                        localAngle.y -= touch.deltaPosition.x/10;
                        obj.getObj().transform.localEulerAngles = localAngle;
                    } 
                }
            }

        }
    }


    //FUTTER BUTTON CLICKEVENTS

    public void pressedMove(string messsage){
        foreach(Furniture obj in furnitureList){
            if(obj.getSelected()){
                obj.changeMoving(true);
                PZScript.DeselectScript();
                obj.setStoredPos(obj.getObj().transform.position);
                UnityMessageManager.Instance.SendMessageToFlutter("canvas6");
            }
        }
    }

    public void pressedRotate(string message){
        foreach(Furniture obj in furnitureList){
            if(obj.getSelected()){
                PZScript.DeselectScript();
                obj.changeRotating(true);
                obj.setStoredRot(obj.getObj().transform.rotation);
                UnityMessageManager.Instance.SendMessageToFlutter("canvas6");
            }
        }
    }

    public void pressedDelete(string message){
        UnityMessageManager.Instance.SendMessageToFlutter("canvas4");
        for(int i = furnitureList.Count-1; i>=0; i--){
            if(furnitureList[i].getSelected()){
                Destroy(furnitureList[i].getObj());
                furnitureList.Remove(furnitureList[i]);
            }
        }
    }

    public void pressedCancel(string messsage){
        UnityMessageManager.Instance.SendMessageToFlutter("canvas5");
        foreach(Furniture obj in furnitureList){
            if(obj.getSelected()){
                obj.getObj().transform.position = obj.getStoredPos();
                obj.getObj().transform.rotation = obj.getStoredRot();
                PZScript.SelectScript();

                obj.changeMoving(false);
                obj.changeRotating(false);
            }
        }
    }

    public void pressedAccept(string message){
        UnityMessageManager.Instance.SendMessageToFlutter("canvas5");
        foreach(Furniture obj in furnitureList){
            if(obj.getSelected()){
                obj.setStoredPos(obj.getObj().transform.position);
                obj.setStoredRot(obj.getObj().transform.rotation);
                PZScript.SelectScript();

                obj.changeMoving(false);
                obj.changeRotating(false);
            }
        }
    }

    public void goToRoomScene(string message){
        foreach(RoomPlane plane in pList){
            plane.getObj().GetComponent<Collider>().enabled = true;
        }
        SceneManager.LoadScene("testing", LoadSceneMode.Single);
    }

    public void createFurniture(string message){
        //there should already be an existing list of furniture assets that are loaded based on prefabs in resources folder
        int idx = int.Parse(message);
        //in the future, idx should correspond to a furniture in the existing list with the same idx key value
        Vector3 objPos = Camera.main.ScreenToWorldPoint(new Vector3(Screen.width/2, Screen.height/2, Camera.main.transform.position.y));
        furnitureList.Add(new Furniture(Instantiate(prefab1, new Vector3(objPos.x, 0, objPos.y), Quaternion.Euler(270,0,0)), 1)); //just to see if it works
        furnitureList[furnitureList.Count-1].changeSelected(true);
        furnitureList[furnitureList.Count-1].changeMoving(true);
        PZScript.DeselectScript();
        UnityMessageManager.Instance.SendMessageToFlutter("canvas6");
    }

    public void pressed3D(string message){ //makes the 3D view gameobjects and their scripts active
        in3D = true;
        PZScript.DeselectScript();
        PZCam.gameObject.SetActive(false);
        _3DCam.gameObject.SetActive(true);
        Cinemachine.gameObject.SetActive(true);
        InputManager.gameObject.SetActive(true);
        _3DCanvas.gameObject.SetActive(true);
        _3DPlayer.gameObject.SetActive(true);      
    }

    public GameObject createWall(RoomPlane plane){ //creates 3D wall based on the 2D wall RoomPlane
        GameObject go = new GameObject("Wall");
        go.tag = "Wall";
        MeshFilter mf = go.AddComponent(typeof(MeshFilter)) as MeshFilter;
        MeshRenderer mr = go.AddComponent(typeof(MeshRenderer)) as MeshRenderer;
        go.transform.position = plane.getObj().transform.position;

        Vector3[] oldVertices = plane.getObj().GetComponent<MeshFilter>().mesh.vertices;
        Mesh m = new Mesh();
        m.vertices = new Vector3[]
        {
            oldVertices[0],
            oldVertices[1],
            oldVertices[2],
            oldVertices[3],
            oldVertices[3] + new Vector3(0, 4, 0),
            oldVertices[2] + new Vector3(0, 4, 0),
            oldVertices[1] + new Vector3(0, 4, 0),
            oldVertices[0] + new Vector3(0, 4, 0)
        };
        m.triangles = new int[]{
            0, 2, 1, //face front
            0, 3, 2,
            2, 3, 4, //face top
            2, 4, 5,
            1, 2, 5, //face right
            1, 5, 6,
            0, 7, 4, //face left
            0, 4, 3,
            5, 4, 7, //face back
            5, 7, 6,
            0, 6, 7, //face bottom
            0, 1, 6,
        };

        mf.mesh = m;
        m.RecalculateBounds();
        m.RecalculateNormals();

        mr.material.SetColor("_Color", new Color(244f/255f, 164f/255f, 96f/255f));

        return go;
    }

    public void pressedExit3D(string message){
        foreach(RoomPlane plane in pList){
            plane.getObj().SetActive(true);
        }
        in3D = false;
        PZScript.SelectScript();
        PZCam.gameObject.SetActive(true);
        _3DCam.gameObject.SetActive(false);
        Cinemachine.gameObject.SetActive(false);
        InputManager.gameObject.SetActive(false);
        _3DCanvas.gameObject.SetActive(false);
        _3DPlayer.gameObject.SetActive(false);
        GameObject[] walls = GameObject.FindGameObjectsWithTag("Wall"); //upon exiting 3D view, destroy all 3D walls
        foreach(GameObject wall in walls){
            GameObject.Destroy(wall);
        }
    }

}
