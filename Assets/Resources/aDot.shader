// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "jojo/Amplify/Unlit/Dot"
{
	Properties
	{
		_mainTexture("mainTexture", 2D) = "white" {}
		_dotNumber("dotNumber", Float) = 0
		_rotateSpeed("rotateSpeed", Float) = 0
		_dissolve("dissolve", Float) = -0.84
		[HDR]_Color_1("Color_1", Color) = (0,0,0,0)
		[HDR]_Color_2("Color_2", Color) = (0,0,0,0)
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
			#include "UnityShaderVariables.cginc"


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

			uniform float4 _Color_1;
			uniform float4 _Color_2;
			uniform float _dissolve;
			uniform half _dotNumber;
			uniform sampler2D _mainTexture;
			uniform sampler2D sampler027;
			uniform float4 _mainTexture_ST;
			uniform sampler2D sampler036;
			uniform float _rotateSpeed;
			
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
				float2 uv25 = i.ase_texcoord.xy * _mainTexture_ST.xy + float2( 0,0 );
				float mulTime31 = _Time.y * _rotateSpeed;
				float cos28 = cos( mulTime31 );
				float sin28 = sin( mulTime31 );
				float2 rotator28 = mul( uv25 - float2( 0.5,0.5 ) , float2x2( cos28 , -sin28 , sin28 , cos28 )) + float2( 0.5,0.5 );
				float2 panner26 = ( 1.0 * _Time.y * _mainTexture_ST.zw + rotator28);
				float3 lerpResult37 = lerp( (_Color_1).rgb , (_Color_2).rgb , floor( ( _dissolve + ( 1.0 - sqrt( dotResult4 ) ) + tex2D( _mainTexture, panner26 ) ) ).rgb);
				
				
				finalColor = float4( lerpResult37 , 0.0 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}