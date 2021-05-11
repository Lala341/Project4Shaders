Shader "Custom/Distortion" {
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Strength ("Strength", float) = 1
        _LuminosityAmount ("GrayscaleAmount", Range(0,1)) = 1.0
    }
    SubShader
    {        
        Pass
        {
            //Blend SrcAlpha OneMinusSrcAlpha
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #include "UnityCG.cginc"
 
            sampler2D _MainTex;
 
            uniform float _Strength;
            fixed _LuminosityAmount;

            half2 GetBarrelUV(half2 p) {
				float theta = atan2(p.y, p.x);
				float radius = length(p);
				radius = pow(radius, _Strength);
				p.x = radius * cos(theta);
				p.y = radius * sin(theta);
				return (p + 0.5);
			}
 
            fixed4 frag(v2f_img i) : COLOR
            {
            	half2 barrelUV = GetBarrelUV(i.uv - 0.5);
                fixed4 col = tex2D(_MainTex, barrelUV.xy);  

                fixed4 renderTex = col;

				float luminosity = 0.299 * renderTex.r + 0.587 * renderTex.g + 0.114 * renderTex.b;
				fixed4 finalColor = lerp(renderTex, luminosity, _LuminosityAmount);

				return finalColor;

            
                
            }
 
            ENDCG
        }
     
    }
    FallBack "Diffuse"
}
