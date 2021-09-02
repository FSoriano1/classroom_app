using UnityEngine;

[RequireComponent(typeof(CharacterController))]
public class CamController : MonoBehaviour
{
    private CharacterController controller;
    private float playerSpeed = 2.0f;
    private InputManager inputManager;
    private Transform cameraTransform;

    private void Start()
    {
        controller = GetComponent<CharacterController>();
        inputManager = InputManager.Instance;
        cameraTransform = Camera.main.transform;
    }


    void Update()
    {
        Vector2 movement = inputManager.GetCamMovement();
        Vector3 move = new Vector3(movement.x, 0, movement.y);
        move = move.x * cameraTransform.right + move.z * cameraTransform.forward;
        move.y = 0f;
        controller.Move(move * Time.deltaTime * playerSpeed);

        if (move != Vector3.zero)
        {
            gameObject.transform.forward = move;
        }

    
    }
}