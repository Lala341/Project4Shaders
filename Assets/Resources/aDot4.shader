// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "jojo/Amplify/Unlit/Dot4"
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
				float3 lerpResult37 = lerp( (_Color_1).rgb , (_Color_2).rgb , ( _dissolve + ( 1.0 - sqrt( dotResult4 ) ) + tex2D( _mainTexture, panner26 ) ).r);
				
				
				finalColor = float4( lerpResult37 , 0.0 );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=15600
1607;1;1426;870;3217.242;2529.247;4.652628;True;False
Node;AmplifyShaderEditor.CommentaryNode;33;-1302.506,140.5335;Float;False;1165.898;302.0018;Comment;7;31;32;36;26;28;27;25;UV 移動旋轉;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;54;711.4592,-582.6918;Float;False;715.9846;522.0895;Comment;17;37;53;47;52;46;51;48;50;49;45;39;38;44;43;42;41;40;染色;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;21;-1307.492,-325.9;Float;False;1776.832;380.1337;Comment;6;22;55;4;2;3;19;Dot - 製作網點圖案;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureTransformNode;36;-1280.862,211.4688;Float;False;23;1;0;SAMPLER2D;sampler036;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.RangedFloatNode;32;-1135.967,327.9476;Float;False;Property;_rotateSpeed;rotateSpeed;2;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;40;731.8782,-532.6918;Float;False;Property;_Color_2;Color_2;5;1;[HDR];Create;True;0;0;False;0;0,0,0,0;2.133084,1.981309,1.11685,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;19;-1286.439,-243.8999;Float;False;780.5719;285.8867;Comment;4;1;5;6;7;控制網點數量;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;31;-962.1166,332.5804;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;25;-1023.608,193.3929;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;41;733.0367,-369.3209;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;42;913.7036,-331.9226;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1226.425,-194.0999;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;28;-741.9601,193.3931;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureTransformNode;27;-604.71,326.3538;Float;False;23;1;0;SAMPLER2D;sampler027;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.RangedFloatNode;7;-1131.466,-66.7001;Half;False;Property;_dotNumber;dotNumber;1;0;Create;True;0;0;False;0;0;15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;26;-318.7716,190.5335;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-920.5671,-193.8999;Float;True;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;43;913.7036,-332.9226;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;44;913.7036,-287.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;38;963.3925,-529.2358;Float;False;Property;_Color_1;Color_1;4;1;[HDR];Create;True;0;0;False;0;0,0,0,0;0.6603774,0.3519936,0.3519936,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;5;-684.6675,-193.5999;Float;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;35;271.8375,-410.6888;Float;False;Property;_dissolve;dissolve;3;0;Create;True;0;0;False;0;-0.84;-0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-489.8671,-66.49995;Float;False;Constant;_fixUVPivot;fixUVPivot;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-69.959,163.4713;Float;True;Property;_mainTexture;mainTexture;0;0;Create;True;0;0;False;0;None;debb8ff3e06188a48ac8e60b101c9cf1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2;-323.7209,-192.3998;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;93;479.0695,202.762;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;79;467.423,-379.2919;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;39;962.5664,-364.5368;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;45;915.7036,-286.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;50;1151.703,-328.9226;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;78;469.423,-378.2919;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;4;-88.99413,-216.04;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;92;477.0695,202.762;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;49;1014.703,-286.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;48;1014.703,-287.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;51;1151.703,-328.9226;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;76;470.423,-213.2919;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;55;122.105,-216.1503;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;94;478.0695,-166.238;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;91;476.0695,-165.238;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;46;1015.703,-232.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;52;1151.703,-253.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;22;295.2153,-216.1148;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;77;472.423,-212.2919;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;512.4216,-239.7199;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;75;-1302.296,-1312.2;Float;False;1551.851;308.3905;Comment;7;71;57;70;65;73;74;84;Dot - 用貼圖做網點;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;53;1150.703,-253.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;47;1017.703,-232.0411;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;16;-1291.561,-2026.077;Float;False;622.9996;303;Dot - step 1;2;8;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-1296.668,-1698.898;Float;False;877.7994;303.1005;Dot - Step 2;4;12;14;15;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;13;-653.8691,-1648.898;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureTransformNode;74;-1252.58,-1248.95;Float;False;65;1;0;SAMPLER2D;sampler074;False;2;FLOAT2;0;FLOAT2;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1246.668,-1648.898;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;9;-903.5606,-1976.077;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;70;-410.444,-1256.809;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;71;51.55595,-1256.809;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;84;-1235.622,-1142.65;Float;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;False;0;5,5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;65;-713.4457,-1262.2;Float;True;Property;_dot1;dot1;6;0;Create;True;0;0;False;0;2729afbedeb1ec341824e47c11da3ae4;7b212d8861cac004f88ef081d083d4ad;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;15;-941.9688,-1648.798;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;73;-215.4442,-1256.809;Float;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;2.01;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1109.369,-1522.897;Float;False;Constant;_Float0;Float 0;0;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;37;1186.299,-284.3927;Float;True;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-1241.561,-1951.377;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-960.9275,-1234.255;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;-0.5,-0.5;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;1470.81,-284.3065;Float;False;True;2;Float;ASEMaterialInspector;0;1;jojo/Amplify/Unlit/Dot4;0770190933193b94aaa3065e307002fa;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque;True;2;0;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;31;0;32;0
WireConnection;25;0;36;0
WireConnection;41;0;40;0
WireConnection;42;0;41;0
WireConnection;28;0;25;0
WireConnection;28;2;31;0
WireConnection;26;0;28;0
WireConnection;26;2;27;1
WireConnection;6;0;1;0
WireConnection;6;1;7;0
WireConnection;43;0;42;0
WireConnection;44;0;43;0
WireConnection;5;0;6;0
WireConnection;23;1;26;0
WireConnection;2;0;5;0
WireConnection;2;1;3;0
WireConnection;93;0;23;0
WireConnection;79;0;35;0
WireConnection;39;0;38;0
WireConnection;45;0;44;0
WireConnection;50;0;39;0
WireConnection;78;0;79;0
WireConnection;4;0;2;0
WireConnection;4;1;2;0
WireConnection;92;0;93;0
WireConnection;49;0;45;0
WireConnection;48;0;49;0
WireConnection;51;0;50;0
WireConnection;76;0;78;0
WireConnection;55;0;4;0
WireConnection;94;0;92;0
WireConnection;91;0;94;0
WireConnection;46;0;48;0
WireConnection;52;0;51;0
WireConnection;22;0;55;0
WireConnection;77;0;76;0
WireConnection;24;0;77;0
WireConnection;24;1;22;0
WireConnection;24;2;91;0
WireConnection;53;0;52;0
WireConnection;47;0;46;0
WireConnection;13;0;15;0
WireConnection;13;1;15;0
WireConnection;9;0;8;0
WireConnection;9;1;8;0
WireConnection;70;0;65;0
WireConnection;71;0;73;0
WireConnection;65;1;57;0
WireConnection;15;0;12;0
WireConnection;15;1;14;0
WireConnection;73;0;70;0
WireConnection;37;0;53;0
WireConnection;37;1;47;0
WireConnection;37;2;24;0
WireConnection;57;0;84;0
WireConnection;0;0;37;0
ASEEND*/
//CHKSM=308B1F767E910BDD3D2C45DBEB9BE160F6214EE7