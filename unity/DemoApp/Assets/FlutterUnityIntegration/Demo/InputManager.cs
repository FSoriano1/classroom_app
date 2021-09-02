using UnityEngine;

public class InputManager : MonoBehaviour
{

    private static InputManager _instance;
    public static InputManager Instance {
        get {
            return _instance;
        }
    }
    private _3DCamControls camControls;

    private void Awake()
    {
        if(_instance != null && _instance != this){
            Destroy(this.gameObject);
        }
        else{
            _instance = this;
        }
        camControls = new _3DCamControls();
    }
 
    private void OnEnable(){
        camControls.Enable();
    }

    private void OnDisable(){
        camControls.Disable();
    }

    public Vector2 GetCamMovement() {
        return camControls.Cam.Move.ReadValue<Vector2>();
    }

    public Vector2 GetMouseDelta() {
        return camControls.Cam.Look.ReadValue<Vector2>();
    }


 }
