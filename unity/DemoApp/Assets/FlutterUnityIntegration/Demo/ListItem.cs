using System;

[Serializable]
public class ListItem{ //retrieves data from Flutter and organizes them
    public PlaneData[] PlaneData;
    public EditDimensions[] EditDimensions;
}

[Serializable]
public class PlaneData{
    public string length;
    public string width;
    public string wall;
    public string horiz;
}

[Serializable]
public class EditDimensions{
    public string length;
    public string width;
}

