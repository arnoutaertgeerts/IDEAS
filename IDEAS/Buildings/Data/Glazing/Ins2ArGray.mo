within IDEAS.Buildings.Data.Glazing;
record Ins2ArGray = IDEAS.Buildings.Data.Interfaces.Glazing (
    nLay=3,
    mats={Materials.Glass(d=0.006),Materials.Argon(d=0.016, epsLw_a=0.100),
        Materials.Glass(d=0.006, epsLw=0.10)},
    SwTrans=[0, 0.316; 10, 0.318; 20, 0.313; 30, 0.306; 40, 0.296; 50, 0.279;
        60, 0.243; 70, 0.176; 80, 0.079; 90, 0.000],
    SwAbs=[0, 0.448, 0.0, 0.064; 10, 0.453, 0.0, 0.064; 20, 0.460, 0.0, 0.065;
        30, 0.463, 0.0, 0.065; 40, 0.461, 0.0, 0.067; 50, 0.461, 0.0, 0.067; 60,
        0.466, 0.0, 0.065; 70, 0.456, 0.0, 0.056; 80, 0.355, 0.0, 0.040; 90,
        0.000, 0.0, 0.000],
    SwTransDif=0.243,
    SwAbsDif={0.466,0.0,0.065},
    U_value=1.3,
    g_value=0.397) "Low SHGC AR 1.3 6/16/6 (U = 1.3 W/m2K, g = 0.397)";
