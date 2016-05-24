uniform sampler2D u_MaskTexture;

void main()
{
    vec4 normalColor = texture2D(cc_MainTexture, cc_FragTexCoord1);
    vec4 maskColor = texture2D(u_MaskTexture, cc_FragTexCoord1);
    float alpha = maskColor.a;
    gl_FragColor = normalColor * alpha;
}