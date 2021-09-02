using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

//This is the first scene to be loaded. "NativeScene" and "SampleScene" aren't used at all for the app. I just wanted to test them to see how they worked.
public class OnLoad : MonoBehaviour //corresponds to "testing" scene, or rather the 2D Room Editor scene
{
    Vector2 beginTouchPosition;
    public PanZoom PZScript;
    public Camera m_camera;
    Vector3 moveTouchStart;
    List<RoomPlane> planeList;
    private SharedData SharedData;
    // Start is called before the first frame update
    void Start()
    {
        SharedData = SharedData.Instance;
        planeList = SharedData.getPlanes();
        if(planeList == null){
            planeList = new List<RoomPlane>();
            //if not new, use a for loop or something to connect to the database and load the preexisting planes
            CreatePlane(10,7,0,0, false, false); //default room plane
            SharedData.setPlanes(planeList);
        }
        
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.touchCount > 0){
            Touch touch = Input.GetTouch(0);
            Ray ray = Camera.main.ScreenPointToRay(touch.position);
            RaycastHit hit;
            bool tap = false;
            Vector2 endTouchPosition;

            switch (touch.phase) {
                case TouchPhase.Began:
                    beginTouchPosition = touch.position;
                    moveTouchStart = touch.position;
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
            if(tap && Physics.Raycast(ray, out hit) && !(touch.phase==TouchPhase.Moved)){
                bool objSelected = false;
                bool objAction = false;
                foreach(RoomPlane plane in planeList){
                    if(plane.getMoving()){
                        objAction = true;
                    }
                }
                
                if(!objAction){
                    foreach(RoomPlane plane in planeList){ 
                        if(plane.getObj().transform == hit.transform){ //if collider is hit
                            objSelected = true;
                            if(!plane.getSelected()){ //if collided plane isn't selected yet, select it
                                if(plane.getWall()){
                                    UnityMessageManager.Instance.SendMessageToFlutter("canvas8"); //these types of messages change flutter ui
                                }
                                else{
                                    UnityMessageManager.Instance.SendMessageToFlutter("canvas2");
                                }
                                plane.changeSelected(true);
                                objSelected = true;
                                MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
                                Vector3 pos = plane.getObj().transform.position;
                                if(plane.getWall()){
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.02f, pos.z);
                                }
                                else{
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                                }
                                mr.material.SetColor("_Color", Color.red);

                            }
                           //else plane is already selected 
                        }
                        else{ 
                            if(plane.getSelected() && !plane.getMoving()){ //deselect all other planes to be safe
                                UnityMessageManager.Instance.SendMessageToFlutter("canvas1");
                                plane.changeSelected(false);
                                MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
                                Vector3 pos = plane.getObj().transform.position;
                                if(plane.getWall()){
                                    mr.material.SetColor("_Color", new Color(139f/255f, 69f/255f, 19f/255f));
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                                }
                                else{
                                    mr.material.SetColor("_Color", new Color(154f/255f, 120f/255f, 76f/255f));
                                    plane.getObj().transform.position = new Vector3(pos.x, 0, pos.z);
                                }
                            }
                            
                        }
                        //then I open the menu for that furniture(move, rotate, delete, color, etc)
                    }
                    if(!objSelected){ //if somehow it hits a collider but no planes, don't think this is possible as of now but I'll keep it
                        foreach(RoomPlane plane in planeList){
                            UnityMessageManager.Instance.SendMessageToFlutter("canvas1");
                            plane.changeSelected(false);
                            MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
                            Vector3 pos = plane.getObj().transform.position;
                            if(plane.getWall()){
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.02f, pos.z);
                                    mr.material.SetColor("_Color", new Color(139f/255f, 69f/255f, 19f/255f));
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                                }
                                else{
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                                    mr.material.SetColor("_Color", new Color(154f/255f, 120f/255f, 76f/255f));
                                    plane.getObj().transform.position = new Vector3(pos.x, 0, pos.z);
                                }
                        }
                        //revert back to PanZoom since planes are deselected
                        PZScript.SelectScript();
                        
                    }
                }
            }
            else{ //if tapped and no collider is hit, deselect all
                if(tap){
                    foreach(RoomPlane plane in planeList){
                        if(plane.getSelected() && !plane.getMoving()){
                            UnityMessageManager.Instance.SendMessageToFlutter("canvas1");
                            plane.changeSelected(false);
                            MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
                            Vector3 pos = plane.getObj().transform.position;
                            if(plane.getWall()){
                                    mr.material.SetColor("_Color", new Color(139f/255f, 69f/255f, 19f/255f));
                                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                                }
                                else{
                                    mr.material.SetColor("_Color", new Color(154f/255f, 120f/255f, 76f/255f));
                                    plane.getObj().transform.position = new Vector3(pos.x, 0, pos.z);
                                }
                        }
                    }
                }
            }

            if(touch.phase == TouchPhase.Moved){ 
                foreach(RoomPlane plane in planeList){
                    //MOVING
                    if(plane.getSelected() && plane.getMoving()){ //if touchphase is moving and plane has moving tag, move the plane
                        PZScript.DeselectScript();
                        Vector3 dir = Camera.main.ScreenToWorldPoint(touch.position) - Camera.main.ScreenToWorldPoint(moveTouchStart);
                        moveTouchStart = touch.position;
                        plane.getObj().transform.position += dir;
                        break;
                    } 
                }
            }

        }
    }

    public GameObject CreatePlane(float height, float width, float x, float z, bool wall, bool horiz){ //function to create a plane mesh
        GameObject go = new GameObject("RoomPlane");
        MeshFilter mf = go.AddComponent(typeof(MeshFilter)) as MeshFilter;
        MeshRenderer mr = go.AddComponent(typeof(MeshRenderer)) as MeshRenderer;
        go.transform.position = new Vector3(x,0,z);

        Mesh m = new Mesh();
        m.vertices = new Vector3[]
        {
            new Vector3(-width/2,0,-height/2),
            new Vector3(-width/2,0,height/2),
            new Vector3(width/2,0,height/2),
            new Vector3(width/2,0,-height/2)
        };

        m.uv = new Vector2[]
        {
            new Vector2(0,0),
            new Vector2(0,1),
            new Vector2(1,1),
            new Vector2(1,0)
        };
        
        m.triangles = new int[]{0,1,2,0,2,3};

        mf.mesh = m;
        m.RecalculateBounds();
        m.RecalculateNormals();

        mr.material.SetColor("_Color", new Color(154f/255f, 120f/255f, 76f/255f));

        go.AddComponent<BoxCollider>(); 
        BoxCollider goBC = go.GetComponent<BoxCollider>();
        goBC.size = new Vector3(width, 1, height);
        go.AddComponent<DontDestroy>(); //if this wasn't here, gameobjects wouldn't be saved into next scene
        planeList.Add(new RoomPlane(go, wall, horiz));
        SharedData.setPlanes(planeList);

        return go;
    }

    public void createPlaneFromFlutter(string message){
        ListItem items = JsonUtility.FromJson<ListItem>(message);
        UnityMessageManager.Instance.SendMessageToFlutter(message);
        float l = float.Parse(items.PlaneData[0].length);
        float w = float.Parse(items.PlaneData[0].width);
        bool wall = bool.Parse(items.PlaneData[0].wall);
        bool horiz = bool.Parse(items.PlaneData[0].horiz); //if true, horizontal. if false, vertical.
        
        Vector3 centerPos = Camera.main.ScreenToWorldPoint(new Vector3(Screen.width/2, Screen.height/2, Camera.main.transform.position.y));
        if(wall){
            if(horiz){
                CreatePlane(0.2f, w, centerPos.x, centerPos.y, true, true); //0.2f is default width of wall
            }
            else{
                CreatePlane(l, 0.2f, centerPos.x, centerPos.y, true, false);
            }
        }
        else{
            CreatePlane(l, w, centerPos.x, centerPos.y, false, false); //if roomplane is not a wall
        }
        
        RoomPlane plane = planeList[planeList.Count-1];
        plane.changeSelected(true);
        plane.changeMoving(true);
        MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
        Vector3 pos = plane.getObj().transform.position;
        if(wall){
            mr.material.SetColor("_Color", Color.red);
            plane.getObj().transform.position = new Vector3(pos.x, 0.02f, pos.z);
        }
        else{
            mr.material.SetColor("_Color", Color.red);
            plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
        }        
        
        UnityMessageManager.Instance.SendMessageToFlutter("canvas3");
    }

    public void adjustPlane(string message){
        ListItem items = JsonUtility.FromJson<ListItem>(message);
        float length = float.Parse(items.EditDimensions[0].length);
        float width = float.Parse(items.EditDimensions[0].width); 
        GameObject go = planeList[0].getObj();
        foreach(RoomPlane plane in planeList){
            if(plane.getSelected() && !plane.getMoving()){
                go = plane.getObj();
                if(plane.getWall()){
                    if(plane.getHoriz()){ //adjusts the length of a side depending on horiz or vert
                        length = 0.2f;
                    }
                    else{
                        width = 0.2f;
                    }
                }
            }
        }
        
        Mesh mesh = go.GetComponent<MeshFilter>().mesh;
        mesh.Clear();

        mesh.vertices = new Vector3[]
        {
            new Vector3(-width/2,0,-length/2),
            new Vector3(-width/2,0,length/2),
            new Vector3(width/2,0,length/2),
            new Vector3(width/2,0,-length/2)
        };

        mesh.uv = new Vector2[]
        {
            new Vector2(0,0),
            new Vector2(0,1),
            new Vector2(1,1),
            new Vector2(1,0)
        };
        
        mesh.triangles = new int[]{0,1,2,0,2,3};


        mesh.RecalculateBounds();
        mesh.RecalculateNormals();

        BoxCollider goBC = go.GetComponent<BoxCollider>();
        goBC.size = new Vector3(width, 1, length);
    }


    //FLUTTER BUTTON CLICKEVENTS

    public void recenter(string message){ //this function works, but there's no recenter button in flutter yet
        m_camera.transform.position = new Vector3(0, 10, 0);
    }

    public void pressMovePlane(string message){
        //should not work if planeList.Count is 1
        if(!(planeList.Count > 1)){
            //do not allow it to be moved. in the future, make the flutter move button disappear instead of a debug message
            UnityMessageManager.Instance.SendMessageToFlutter("ONLY 1 PLANE LEFT. Cannot Move!");
        }
        else{
            foreach(RoomPlane plane in planeList){
                if(plane.getSelected()){
                    plane.changeMoving(true);
                    UnityMessageManager.Instance.SendMessageToFlutter("canvas3");
                    break;
                }
            }
        }
    }

    public void pressedAccept(string message){
        foreach(RoomPlane plane in planeList){
            if(plane.getSelected()){
                plane.setStoredPos(plane.getObj().transform.position);
                plane.changeMoving(false);
                MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
                Vector3 pos = plane.getObj().transform.position;
                mr.material.SetColor("_Color", Color.red);
                if(plane.getWall()){
                    UnityMessageManager.Instance.SendMessageToFlutter("canvas8");                
                    plane.getObj().transform.position = new Vector3(pos.x, 0.02f, pos.z);
                }
                else{
                    UnityMessageManager.Instance.SendMessageToFlutter("canvas2");
                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                }
            }
            PZScript.SelectScript();
        }
    }

    public void pressedCancel(string message){
        foreach(RoomPlane plane in planeList){
            if(plane.getSelected()){
                plane.getObj().transform.position = plane.getStoredPos();
                plane.changeMoving(false);
            }
            MeshRenderer mr = plane.getObj().GetComponent<MeshRenderer>();
            Vector3 pos = plane.getObj().transform.position;
            mr.material.SetColor("_Color", Color.red);
            if(plane.getWall()){
                    UnityMessageManager.Instance.SendMessageToFlutter("canvas8");
                    plane.getObj().transform.position = new Vector3(pos.x, 0.02f, pos.z);
                }
                else{
                    UnityMessageManager.Instance.SendMessageToFlutter("canvas2");
                    plane.getObj().transform.position = new Vector3(pos.x, 0.01f, pos.z);
                }
            PZScript.SelectScript();
        }
    }

    public void pressDeletePlane(string message){         //i tested this and it should work, as long as the function isn't called in a foreach loop
        if(!(planeList.Count > 1)){
            //do not allow it to be deleted. in the future display a pop-up message instead of a debug message
            UnityMessageManager.Instance.SendMessageToFlutter("ONLY 1 PLANE LEFT. CANNOT DELETE!");
        }
        else{
            for(int i = planeList.Count-1; i>=0; i--){
                if(planeList[i].getSelected()){
                    Destroy(planeList[i].getObj());
                    planeList.Remove(planeList[i]);
                    UnityMessageManager.Instance.SendMessageToFlutter("canvas1");
                    break;
                }
            }
        }
    }

    public void goToMainScene(string message){
        SharedData.setPlanes(planeList);
        SceneManager.LoadScene("MainScene", LoadSceneMode.Single);
    }

}
