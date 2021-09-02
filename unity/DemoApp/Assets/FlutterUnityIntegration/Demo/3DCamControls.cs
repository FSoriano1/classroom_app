// GENERATED AUTOMATICALLY FROM 'Assets/FlutterUnityIntegration/Demo/3DCamControls.inputactions'

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Utilities;

public class @_3DCamControls : IInputActionCollection, IDisposable
{
    public InputActionAsset asset { get; }
    public @_3DCamControls()
    {
        asset = InputActionAsset.FromJson(@"{
    ""name"": ""3DCamControls"",
    ""maps"": [
        {
            ""name"": ""Cam"",
            ""id"": ""8231f11f-c5a0-47fb-bb71-e3ab8f16e538"",
            ""actions"": [
                {
                    ""name"": ""Move"",
                    ""type"": ""Value"",
                    ""id"": ""3b9b4c3b-29fd-4506-b97f-073324abcb44"",
                    ""expectedControlType"": ""Vector2"",
                    ""processors"": """",
                    ""interactions"": """"
                },
                {
                    ""name"": ""Look"",
                    ""type"": ""Value"",
                    ""id"": ""38be7cc4-7f47-4f3a-8074-f64567741dc8"",
                    ""expectedControlType"": ""Vector2"",
                    ""processors"": """",
                    ""interactions"": """"
                }
            ],
            ""bindings"": [
                {
                    ""name"": """",
                    ""id"": ""10ccccfb-4e0f-4302-9909-d7d26f124f6a"",
                    ""path"": ""<Gamepad>/leftStick"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Move"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                },
                {
                    ""name"": """",
                    ""id"": ""dc32c590-f0d1-4fc2-92ac-9737cee9c4cc"",
                    ""path"": ""<Gamepad>/rightStick"",
                    ""interactions"": """",
                    ""processors"": """",
                    ""groups"": """",
                    ""action"": ""Look"",
                    ""isComposite"": false,
                    ""isPartOfComposite"": false
                }
            ]
        }
    ],
    ""controlSchemes"": []
}");
        // Cam
        m_Cam = asset.FindActionMap("Cam", throwIfNotFound: true);
        m_Cam_Move = m_Cam.FindAction("Move", throwIfNotFound: true);
        m_Cam_Look = m_Cam.FindAction("Look", throwIfNotFound: true);
    }

    public void Dispose()
    {
        UnityEngine.Object.Destroy(asset);
    }

    public InputBinding? bindingMask
    {
        get => asset.bindingMask;
        set => asset.bindingMask = value;
    }

    public ReadOnlyArray<InputDevice>? devices
    {
        get => asset.devices;
        set => asset.devices = value;
    }

    public ReadOnlyArray<InputControlScheme> controlSchemes => asset.controlSchemes;

    public bool Contains(InputAction action)
    {
        return asset.Contains(action);
    }

    public IEnumerator<InputAction> GetEnumerator()
    {
        return asset.GetEnumerator();
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }

    public void Enable()
    {
        asset.Enable();
    }

    public void Disable()
    {
        asset.Disable();
    }

    // Cam
    private readonly InputActionMap m_Cam;
    private ICamActions m_CamActionsCallbackInterface;
    private readonly InputAction m_Cam_Move;
    private readonly InputAction m_Cam_Look;
    public struct CamActions
    {
        private @_3DCamControls m_Wrapper;
        public CamActions(@_3DCamControls wrapper) { m_Wrapper = wrapper; }
        public InputAction @Move => m_Wrapper.m_Cam_Move;
        public InputAction @Look => m_Wrapper.m_Cam_Look;
        public InputActionMap Get() { return m_Wrapper.m_Cam; }
        public void Enable() { Get().Enable(); }
        public void Disable() { Get().Disable(); }
        public bool enabled => Get().enabled;
        public static implicit operator InputActionMap(CamActions set) { return set.Get(); }
        public void SetCallbacks(ICamActions instance)
        {
            if (m_Wrapper.m_CamActionsCallbackInterface != null)
            {
                @Move.started -= m_Wrapper.m_CamActionsCallbackInterface.OnMove;
                @Move.performed -= m_Wrapper.m_CamActionsCallbackInterface.OnMove;
                @Move.canceled -= m_Wrapper.m_CamActionsCallbackInterface.OnMove;
                @Look.started -= m_Wrapper.m_CamActionsCallbackInterface.OnLook;
                @Look.performed -= m_Wrapper.m_CamActionsCallbackInterface.OnLook;
                @Look.canceled -= m_Wrapper.m_CamActionsCallbackInterface.OnLook;
            }
            m_Wrapper.m_CamActionsCallbackInterface = instance;
            if (instance != null)
            {
                @Move.started += instance.OnMove;
                @Move.performed += instance.OnMove;
                @Move.canceled += instance.OnMove;
                @Look.started += instance.OnLook;
                @Look.performed += instance.OnLook;
                @Look.canceled += instance.OnLook;
            }
        }
    }
    public CamActions @Cam => new CamActions(this);
    public interface ICamActions
    {
        void OnMove(InputAction.CallbackContext context);
        void OnLook(InputAction.CallbackContext context);
    }
}
