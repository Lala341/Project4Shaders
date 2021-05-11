// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "jojo/Amplify/Unlit/Dot2"
{
	Properties
	{
		_mainTexture("mainTexture", 2D) = "white" {}
		_dotNumber("dotNumber", Float) = 0
		_dissolve("dissolve", Float) = -0.84
		[HDR]_dotColor("dotColor", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		

		Pass
		{
			Name "Unlit"
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float _dissolve;
			uniform half _dotNumber;
			uniform sampler2D _mainTexture;
			uniform float4 _mainTexture_ST;
			uniform float4 _dotColor;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float2 uv1 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float2 temp_cast_0 = (0.5).xx;
				float2 temp_output_2_0 = ( frac( ( uv1 * _dotNumber ) ) - temp_cast_0 );
				float2 temp_cast_1 = (0.5).xx;
				float dotResult4 = dot( temp_output_2_0 , temp_output_2_0 );
				float2 uv_mainTexture = i.ase_texcoord.xy * _mainTexture_ST.xy + _mainTexture_ST.zw;
				float4 temp_output_24_0 = ( _dissolve + ( 1.0 - sqrt( dotResult4 ) ) + tex2D( _mainTexture, uv_mainTexture ) );
				float4 lerpResult80 = lerp( float4( 0,0,0,0 ) , ( temp_output_24_0 * _dotColor ) , temp_output_24_0.r);
				
				
				finalColor = lerpResult80;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}