﻿using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class PanZoom : MonoBehaviour
{
    /// <summary> Called as soon as the player touches the screen. The argument is the screen position. </summary>
    public event Action<Vector2> onStartTouch;
    /// <summary> Called as soon as the player stops touching the screen. The argument is the screen position. </summary>
    public event Action<Vector2> onEndTouch;
    /// <summary> Called if the player completed a quick tap motion. The argument is the screen position. </summary>
    public event Action<Vector2> onTap;
    /// <summary> Called if the player swiped the screen. The argument is the screen movement delta. </summary>
    public event Action<Vector2> onSwipe;
    /// <summary> Called if the player pinched the screen. The arguments are the distance between the fingers before and after. </summary>
    public event Action<float, float> onPinch;

    [Header("Tap")]
    [Tooltip("The maximum movement for a touch motion to be treated as a tap")]
    public float maxDistanceForTap = 40;
    [Tooltip("The maximum duration for a touch motion to be treated as a tap")]
    public float maxDurationForTap = 0.4f;

    [Header("Desktop debug")]
    [Tooltip("Use the mouse on desktop?")]
    public bool useMouse = false;
    [Tooltip("The simulated pinch speed using the scroll wheel")]
    public float mouseScrollSpeed = 2;

    [Header("Camera control")]
    [Tooltip("Does the script control camera movement?")]
    public bool controlCamera = true;
    [Tooltip("The controlled camera, ignored of controlCamera=false")]
    public Camera cam;
    public Camera cam2;

    [Header("UI")]
    [Tooltip("Are touch motions listened to if they are over UI elements?")]
    public bool ignoreUI = false;

    [Header("Bounds")]
    [Tooltip("Is the camera bound to an area?")]
    public bool useBounds;

    public bool EnablePan;

    public float boundMinX = -10;
    public float boundMaxX = 10;
    public float boundMinY = -10;
    public float boundMaxY = 10;

    [Header("Zoom level")]
    [Tooltip("Min and Max zoom levels")]
    public float zoomOutMin = 1;
    public float zoomOutMax = 20;

    Vector2 touch0StartPosition;
    Vector2 touch0LastPosition;
    float touch0StartTime;

    bool cameraControlEnabled = true;

    bool canUseMouse;

    

    /// <summary> Has the player at least one finger on the screen? </summary>
    public bool isTouching { get; private set; }

    /// <summary> The point of contact if it exists in Screen space. </summary>
    public Vector2 touchPosition { get { return touch0LastPosition; } }

    void Start()
    {
        EnablePan = true;
        //canUseMouse = Application.platform != RuntimePlatform.Android && Application.platform != RuntimePlatform.IPhonePlayer && Input.mousePresent;
        canUseMouse = false;
    }

    void Update()
    {
        if (EnablePan)
        {
            if (useMouse && canUseMouse)
            {
                UpdateWithMouse();

            }
            else
            {
                UpdateWithTouch();

            }
        }
    }

    void LateUpdate()
    {
        CameraInBounds();
    }
    public void DeselectScript()
    {
        EnablePan = false;
        //isTouching = false;
        Debug.Log("DeselectScript is working ? " + EnablePan);
        //Debug.Log("isTouching is working 1 ? " + ignoreUI);

        Update();
    }
    public void SelectScript()
    {
        EnablePan = true;
        Debug.Log("SelectScript is working ? " + EnablePan);
        //Start();
        Update();
    }


    public void UpdateWithMouse()
    {
       
            if (Input.GetMouseButtonDown(0))
            {
                if (ignoreUI || !IsPointerOverUIObject())
                {

                    touch0StartPosition = Input.mousePosition;
                    touch0StartTime = Time.time;
                    touch0LastPosition = touch0StartPosition;

                    isTouching = true;

                    if (onStartTouch != null) onStartTouch(Input.mousePosition);

                }
            }

            if (Input.GetMouseButton(0) && isTouching)
            {

                Vector2 move = (Vector2)Input.mousePosition - touch0LastPosition;
                touch0LastPosition = Input.mousePosition;

                if (move != Vector2.zero)
                {
                    OnSwipe(move);
                }
            }

            if (Input.GetMouseButtonUp(0) && isTouching)
            {

                if (Time.time - touch0StartTime <= maxDurationForTap
                   && Vector2.Distance(Input.mousePosition, touch0StartPosition) <= maxDistanceForTap)
                {
                    OnClick(Input.mousePosition);
                }

                if (onEndTouch != null) onEndTouch(Input.mousePosition);
                isTouching = false;
                cameraControlEnabled = true;
            }

            if (Input.mouseScrollDelta.y != 0)
            {
                OnPinch(Input.mousePosition, 1, Input.mouseScrollDelta.y < 0 ? (1 / mouseScrollSpeed) : mouseScrollSpeed, Vector2.right);
            }
        


    }

    void UpdateWithTouch()
    {
        int touchCount = Input.touches.Length;

        if (touchCount == 1)
        {
            Touch touch = Input.touches[0];

            switch (touch.phase)
            {
                case TouchPhase.Began:
                    {
                        if (ignoreUI || !IsPointerOverUIObject())
                        {
                            touch0StartPosition = touch.position;
                            touch0StartTime = Time.time;
                            touch0LastPosition = touch0StartPosition;

                            isTouching = true;

                            if (onStartTouch != null) onStartTouch(touch0StartPosition);
                        }

                        break;
                    }
                case TouchPhase.Moved:
                    {
                        touch0LastPosition = touch.position;

                        if (touch.deltaPosition != Vector2.zero && isTouching)
                        {
                            OnSwipe(touch.deltaPosition);
                        }
                        break;
                    }
                case TouchPhase.Ended:
                    {
                        if (Time.time - touch0StartTime <= maxDurationForTap
                            && Vector2.Distance(touch.position, touch0StartPosition) <= maxDistanceForTap
                            && isTouching)
                        {
                            OnClick(touch.position);
                        }

                        if (onEndTouch != null) onEndTouch(touch.position);
                        isTouching = false;
                        cameraControlEnabled = true;
                        break;
                    }
                case TouchPhase.Stationary:
                case TouchPhase.Canceled:
                    break;
            }

        }
        else if (touchCount == 2)
        {
            Touch touch0 = Input.touches[0];
            Touch touch1 = Input.touches[1];

            if (touch0.phase == TouchPhase.Ended || touch1.phase == TouchPhase.Ended) return;

            isTouching = true;

            float previousDistance = Vector2.Distance(touch0.position - touch0.deltaPosition, touch1.position - touch1.deltaPosition);

            float currentDistance = Vector2.Distance(touch0.position, touch1.position);

            if (previousDistance != currentDistance)
            {
                OnPinch((touch0.position + touch1.position) / 2, previousDistance, currentDistance, (touch1.position - touch0.position).normalized);
            }
        }
        else
        {
            if (isTouching)
            {
                if (onEndTouch != null) onEndTouch(touch0LastPosition);
                isTouching = false;
            }

            cameraControlEnabled = true;
        }
    }

    void OnClick(Vector2 position)
    {
        if (onTap != null && (ignoreUI || !IsPointerOverUIObject()))
        {
            onTap(position);
        }
    }
    void OnSwipe(Vector2 deltaPosition)
    {
        if (onSwipe != null)
        {
            onSwipe(deltaPosition);
        }

        if (controlCamera && cameraControlEnabled)
        {
            if (cam == null) cam = Camera.main;

            cam.transform.position -= (cam.ScreenToWorldPoint(deltaPosition) - cam.ScreenToWorldPoint(Vector2.zero));
        }
    }
    void OnPinch(Vector2 center, float oldDistance, float newDistance, Vector2 touchDelta)
    {
        if (onPinch != null)
        {
            onPinch(oldDistance, newDistance);
        }

        if (controlCamera && cameraControlEnabled)
        {
            /*if (cam == null)*/
            //cam = Camera.main;

            if (cam.orthographic)
            {
                var currentPinchPosition = cam.ScreenToWorldPoint(center);

                cam.orthographicSize = Mathf.Clamp(Mathf.Max(0.1f, cam.orthographicSize * oldDistance / newDistance), zoomOutMin, zoomOutMax);
                //Debug.Log("Camera Size is: " + cam.orthographicSize);
                var newPinchPosition = cam.ScreenToWorldPoint(center);

                cam.transform.position -= newPinchPosition - currentPinchPosition;
                //Debug.Log("Camera new Size is: " + cam.transform.position);
            }
            else
            {
                cam.fieldOfView = Mathf.Clamp(cam.fieldOfView * oldDistance / newDistance, 0.1f, 179.9f);
            }
            if (cam2.orthographic)
            {
                var currentPinchPosition2 = cam2.ScreenToWorldPoint(center);

                cam2.orthographicSize = cam.orthographicSize - 154.665f;
                //Debug.Log("Camera Size is: " + cam2.orthographicSize);
                var newPinchPosition2 = cam2.ScreenToWorldPoint(center);

                cam2.transform.position -= newPinchPosition2 - currentPinchPosition2;
                //Debug.Log("Camera new Size is: " + cam2.transform.position);
            }
            else
            {
                cam2.fieldOfView = Mathf.Clamp(cam2.fieldOfView * oldDistance / newDistance, 0.1f, 179.9f);
            }
        }
    }

    /// <summary> Checks if the the current input is over canvas UI </summary>
    public bool IsPointerOverUIObject()
    {

        if (EventSystem.current == null) return false;
        PointerEventData eventDataCurrentPosition = new PointerEventData(EventSystem.current);
        eventDataCurrentPosition.position = new Vector2(Input.mousePosition.x, Input.mousePosition.y);
        List<RaycastResult> results = new List<RaycastResult>();
        EventSystem.current.RaycastAll(eventDataCurrentPosition, results);
        return results.Count > 0;
    }

    /// <summary> Cancels camera movement for the current motion. Resets to use camera at the end of the touch motion.</summary>
    public void CancelCamera()
    {
        cameraControlEnabled = false;
    }

    void CameraInBounds()
    {
        if (controlCamera && useBounds && cam != null && cam.orthographic)
        {
            //right below this was the original code. I'm not fully sure how it works, but it seems to take into account screen space rather
            //than purely world space. It's weird. I don't even know what the bounds are supposed to mean if they're not world space.
            /*cam.orthographicSize = Mathf.Min(cam.orthographicSize, ((boundMaxY - boundMinY) / 2) - 0.001f);
            cam.orthographicSize = Mathf.Min(cam.orthographicSize, (Screen.height * (boundMaxX - boundMinX) / (2 * Screen.width)) - 0.001f);

            Vector2 margin = cam.ScreenToWorldPoint((Vector2.up * Screen.height / 2) + (Vector2.right * Screen.width / 2)) - cam.ScreenToWorldPoint(Vector2.zero);
            Debug.Log(Screen.height);
            float marginX = margin.x;
            float marginY = margin.y;
            
            float camMaxX = boundMaxX - marginX;
            float camMaxY = boundMaxY - marginY;
            float camMinX = boundMinX + marginX;
            float camMinY = boundMinY + marginY;

            float camX = Mathf.Clamp(cam.transform.position.x, camMinX, camMaxX);
            float camY = Mathf.Clamp(cam.transform.position.y, camMinY, camMaxY);*/ 
            float camX = Mathf.Clamp(cam.transform.position.x, boundMinX, boundMaxX);
            float camY = Mathf.Clamp(cam.transform.position.y, boundMinY, boundMaxY);

            cam.transform.position = new Vector3(camX, camY, cam.transform.position.z);
        }
    }








    /*Vector3 touchStart;
    Touch touchZero;
    Touch touchOne;
    public float zoomOutMin = 1;
    public float zoomOutMax = 8;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Input.GetMouseButtonDown(0)){
            touchStart = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            Debug.Log(Camera.main);
        }
        if(Input.touchCount == 2){
            Debug.Log("BRUH 2");
            touchZero = Input.GetTouch(0);
            touchOne = Input.GetTouch(1);
            //touchStart = Camera.main.ScreenToWorldPoint(touchZero.position);

            Vector2 touchZeroPrevPos = touchZero.position - touchZero.deltaPosition;
            Vector2 touchOnePrevPos = touchOne.position - touchOne.deltaPosition;

            float prevMagnitude = (touchZeroPrevPos - touchOnePrevPos).magnitude;
            float currentMagnitude = (touchZero.position - touchOne.position).magnitude;

            float difference = currentMagnitude - prevMagnitude;

            zoom(difference * 0.01f);
        }
        else if(Input.GetMouseButton(0)){
            if((Input.GetTouch(0).position - Input.GetTouch(0).deltaPosition) == touchZero.position){
                Debug.Log("Bruh 4");
                touchStart = Camera.main.ScreenToWorldPoint(touchZero.position);
            }
            if((Input.GetTouch(0).position - Input.GetTouch(0).deltaPosition) == touchOne.position){
                Debug.Log("Bruh 5");
                touchStart = Camera.main.ScreenToWorldPoint(touchOne.position);
            }
            Vector3 direction = touchStart - Camera.main.ScreenToWorldPoint(Input.mousePosition);
            Camera.main.transform.position += direction;
        }
        //zoom(Input.GetAxis("Mouse ScrollWheel"));
    }

    void zoom(float increment){
        Debug.Log("Bruh 3");
        Camera.main.orthographicSize = Mathf.Clamp(Camera.main.orthographicSize - increment, zoomOutMin, zoomOutMax);
    }*/
}
