using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class Pelotas : MonoBehaviour
{
    float bounceForce = 6f;
    List<GameObject> objects= new List<GameObject>();
    List<Color> colors= new List<Color>();
    int numberObjects=300;
    float minscale=0f;
    float maxscale=6f;
    float minx=-48f;
    float maxx=160f;
     float miny=3f;
    float maxy=0.2f;
    float minz=-116f;
    float maxz=270f;
    Vector3 center= new Vector3(128f,42f,35f);
    GameObject boto1;
    GameObject boto2;
    GameObject boto3;
    GameObject boto4;
    float load=0.07f;
    public bool distortion=false;

    AudioSource source;
    GameObject [] cubes;

    public float SpectrumRefreshTime;
    public float lastUpdate = 0;
    public float[] spectrum = new float[1024];
    public float scaleFactor = 2f;

    public GameObject camera;

    float getCurrent()
    {    float sum=0;
             
            float[] temp=spectrum;
            for (int i = 0;i < spectrum.Length; i++)
            {
                sum=sum+temp[i];
            }
            lastUpdate = (sum/2)+1;
        return (sum/2)+1;
    }

    // Start is called before the first frame update
    float getDistance(GameObject obj){

        return (float) (Math.Sqrt((obj.transform.localPosition.x-center.x)*(obj.transform.localPosition.x-center.x)+(obj.transform.localPosition.z-center.z)*(obj.transform.localPosition.z-center.z)))/100;

    }
    public void changeDistortion(){
         distortion=!distortion;
        camera.GetComponent<DistortionFX>().enabled = distortion;
        
    }
    public void changeRangeDistortion(float newValue){
         camera.GetComponent<DistortionFX>().setAmo( newValue);
        
    }
    public void changeLines(){
         Material runtimeMaterial = Resources.Load<Material> ("Lines");

        
        GameObject obj;
        for(int i=0; i<numberObjects;i++){
            obj=objects[i];
            obj.GetComponent<Renderer>().material = runtimeMaterial;

        }
        

        
    }
    public void changeHolo(){
         Material runtimeMaterial = Resources.Load<Material> ("CubeHolo");

        
        GameObject obj;
        for(int i=0; i<numberObjects;i++){
            obj=objects[i];
            obj.GetComponent<Renderer>().material = runtimeMaterial;

        }
    }
    public void changeVolume(float newValue){
         bounceForce = 10f*(newValue+0.1f);
    }
    void Start()
    {
        GameObject sphere;
        float scale;
        System.Random _random = new System.Random();  
        float x;
        float y;
        float z;
        colors.Add(new Color(0.164f, 0.164f, 0.290f));
colors.Add(new Color(0.066f, 0.305f, 0.670f));
colors.Add(new Color(0f, 0.647f, 0.733f));
colors.Add(new Color(1f, 0.509f, 0.149f));
colors.Add(new Color(0.980f, 0.121f, 0.435f));
Color color;
        for(int i=0; i<numberObjects;i++){
        
        sphere = GameObject.CreatePrimitive(PrimitiveType.Sphere);
        scale=  (float) _random.NextDouble()*maxscale+minscale;  
        x=  (float) _random.NextDouble()*maxx+minx;  
        y= (float) _random.NextDouble()*maxy+miny; 
        z= (float) _random.NextDouble()*maxz+minz;  
        color=colors[_random.Next(0,4)];
        
        configureObjectLocal(sphere, gameObject,x,y,z, scale,scale,scale, 0f, 0f, 0f, color);
        sphere.AddComponent<Rigidbody>();

        objects.Add(sphere);
        }

        boto1 = GameObject.Find("Boto1");
        boto2 = GameObject.Find("Boto2");
        boto3 = GameObject.Find("Boto3");
        boto4 = GameObject.Find("Boto4");

        source = GetComponent<AudioSource>();
        cubes = new GameObject[1024];

        camera = GameObject.Find("Main Camera");
                camera.GetComponent<DistortionFX>().enabled = distortion;


        
    }

    // Update is called once per frame
    void Update()
    {
        boto1.gameObject.transform.localScale = new Vector3(boto1.gameObject.transform.localScale.x+load,boto1.gameObject.transform.localScale.y, boto1.gameObject.transform.localScale.z);
        boto2.gameObject.transform.localScale = new Vector3(boto2.gameObject.transform.localScale.x+load,boto2.gameObject.transform.localScale.y, boto2.gameObject.transform.localScale.z);
        boto3.gameObject.transform.localScale = new Vector3(boto3.gameObject.transform.localScale.x+load,boto3.gameObject.transform.localScale.y, boto3.gameObject.transform.localScale.z);
        boto4.gameObject.transform.localScale = new Vector3(boto4.gameObject.transform.localScale.x+load,boto4.gameObject.transform.localScale.y, boto4.gameObject.transform.localScale.z);
        
        if(load>0){
            load=-0.07f;
        }else{
             load=0.07f;
        }
        source.GetSpectrumData(spectrum, 0, FFTWindow.Rectangular);
        
    }
void OnCollisionEnter(Collision hit ) {
    
     hit.rigidbody.AddForce(bounceForce*getCurrent() * transform.up*(7f-hit.gameObject.transform.localScale.x)*getDistance(hit.gameObject), ForceMode.VelocityChange); 

hit.gameObject.transform.localScale = new Vector3(hit.gameObject.transform.localScale.x-0.07f,hit.gameObject.transform.localScale.y,hit.gameObject.transform.localScale.z);
        hit.gameObject.transform.localScale = new Vector3(hit.gameObject.transform.localScale.x+0.07f,hit.gameObject.transform.localScale.y,hit.gameObject.transform.localScale.z);

 } 
   void Jump (GameObject obj) {
obj.GetComponent<Rigidbody>().useGravity = true;
obj.GetComponent<Rigidbody>().AddForce(bounceForce * transform.up, ForceMode.VelocityChange);

}

    void configureObjectLocal(GameObject obj, GameObject parent, float posx, float posy, float posz, float scalex, float scaley, float scalez, float rotx, float roty, float rotz, Color color) {

         obj.transform.localPosition = new Vector3(posx, posy, posz);
        obj.gameObject.transform.localEulerAngles = new Vector3(rotx, roty, rotz);
        obj.gameObject.transform.localScale = new Vector3(scalex, scaley, scalez);
        Material runtimeMaterial = new Material(Shader.Find("VertexLit"));
       obj.GetComponent<Renderer>().material = runtimeMaterial;
    obj.GetComponent<Renderer>().material.SetColor("_Color", color);

    }
}
