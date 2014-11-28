within IDEAS.DistrictHeating;
package HydraulicCircuits "Collection of basic hydraulic circuits"
  model Mixer
    //Extensions
    extends BaseClasses.HydraulicCircuitPartial;

    Fluid.FixedResistances.SplitterFixedResistanceDpM spl(
      redeclare package Medium = Medium1,
      m_flow_nominal={m1_flow_nominal,m1_flow_nominal,-m1_flow_nominal},
      dp_nominal={0,0,0})
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=0,
          origin={-14,-60})));
    Fluid.Valves.Thermostatic3WayValve idealCtrlMixer(
      redeclare package Medium = Medium1, m_flow_nominal=m1_flow_nominal)
                                     annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={-14,0})));
    Fluid.Movers.Pump pump(useInput=true,
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Controls.ControlHeating.HeatingCurve heatingCurve(
      dTOutHeaBal=0,
      TSup_nominal=343.15,
      TSupMin=318.15,
      TRet_nominal=293.15,
      TOut_nominal=273.15,
      use_TRoo_in=true)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-20,36})));
    outer SimInfoManager sim
      annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-14,70})));
    Modelica.Blocks.Interfaces.RealInput TSet "Setpoint temperature" annotation (
        Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={-40,114})));
  equation
    connect(port_a1, idealCtrlMixer.port_a1) annotation (Line(
        points={{-100,60},{-80,60},{-80,1.33227e-015},{-24,1.33227e-015}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_a2, spl.port_1) annotation (Line(
        points={{100,-60},{-4,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(spl.port_3, idealCtrlMixer.port_a2) annotation (Line(
        points={{-14,-50},{-14,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_b2, spl.port_2) annotation (Line(
        points={{-100,-60},{-24,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(idealCtrlMixer.port_b, pump.port_a) annotation (Line(
        points={{-4,-1.33227e-015},{4,-1.33227e-015},{4,0},{10,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pump.port_b, port_b1) annotation (Line(
        points={{30,0},{60,0},{60,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(heatingCurve.TSup, idealCtrlMixer.TMixedSet) annotation (Line(
        points={{-14,25},{-14,10}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(heatingCurve.TOut, realExpression.y) annotation (Line(
        points={{-14,48},{-14,59}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(TSet, heatingCurve.TRoo_in) annotation (Line(
        points={{-40,114},{-40,60},{-26,60},{-26,47.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(ControlInput, pump.m_flowSet) annotation (Line(
        points={{0,114},{0,60},{20,60},{20,10.4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Polygon(
            points={{-60,70},{-60,50},{-40,60},{-60,70}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-10,10},{-10,-10},{10,0},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            origin={-40,50},
            rotation=90),
          Polygon(
            points={{-10,10},{-10,-10},{10,0},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={-30,60},
            rotation=180),
          Line(
            points={{-100,60},{-60,60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-100,-60},{94,-60},{100,-60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-40,40},{-40,-60}},
            color={0,0,255},
            smooth=Smooth.None),
          Ellipse(
            extent={{20,80},{60,40}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-10,10},{-10,-22},{22,-6},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={38,66},
            rotation=360),
          Line(
            points={{-20,60},{20,60}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{60,60},{90,60}},
            color={0,0,255},
            smooth=Smooth.None)}));
  end Mixer;

  model Direct

    //Extensions
    extends BaseClasses.HydraulicCircuitPartial;

    Fluid.Actuators.Valves.TwoWayEqualPercentage val(
      m_flow(nominal=0.1),
      redeclare package Medium=Medium1,
      dpValve_nominal=20,
      m_flow_nominal=0.1)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
    Modelica.Blocks.Interfaces.RealInput TSet
      "Setpoint temperature of the room" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=270,
          origin={0,112})));
  equation
    connect(port_a1, val.port_a) annotation (Line(
        points={{-100,60},{-10,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(val.port_b, port_b1) annotation (Line(
        points={{10,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_a2, port_b2) annotation (Line(
        points={{100,-60},{-100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ControlInput, val.y) annotation (Line(
        points={{0,114},{0,72}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(graphics={
          Polygon(
            points={{-20,70},{-20,50},{0,60},{-20,70}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-10,10},{-10,-10},{10,0},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={10,60},
            rotation=180)}));
  end Direct;

  model SinglePump "Base circuit controlled by a single pump"

    //Extensions
    extends BaseClasses.HydraulicCircuitPartial;

    Fluid.Movers.Pump pump(useInput=true,
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  equation
    connect(pump.port_b, port_b1) annotation (Line(
        points={{10,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pump.port_a, port_a1) annotation (Line(
        points={{-10,60},{-100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_b2, port_a2) annotation (Line(
        points={{-100,-60},{100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(ControlInput, pump.m_flowSet) annotation (Line(
        points={{0,114},{0,70.4}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
          graphics={
          Polygon(
            points={{-10,10},{-10,-22},{22,-6},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={-2,66},
            rotation=360),
          Ellipse(
            extent={{-20,80},{20,40}},
            lineColor={0,0,255},
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-10,10},{-10,-22},{22,-6},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={-2,66},
            rotation=360)}));
  end SinglePump;

  model ZoneSplitter
    "Model to split a fluid inlet into multiple outlets and back"

    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component";

    //Parameters
    parameter Integer n(min=1) "Number of outgoing connections";

    //Components
    Modelica.Fluid.Interfaces.FluidPort_b port_bN[n](
      redeclare final package Medium = Medium)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-70,92},{-50,112}},
              rotation=0), iconTransformation(extent={{-70,92},{-50,112}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_aN[n](
      redeclare final package Medium = Medium)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{70,92},{50,112}},  rotation=
               0), iconTransformation(extent={{70,92},{50,112}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(
      redeclare final package Medium =Medium)
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-70,-108},{-50,-88}},
            rotation=0), iconTransformation(extent={{-70,-108},{-50,-88}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(
      redeclare final package Medium = Medium)
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{70,-110},{50,-90}}, rotation=0),
          iconTransformation(extent={{70,-110},{50,-90}})));
  equation
    for i in 1:n loop
      connect(port_bN[i], port_a);
      connect(port_aN[i], port_b);
    end for;
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Line(
            points={{-60,-100},{-60,102},{-60,100}},
            color={0,0,255},
            smooth=Smooth.None), Line(
            points={{60,-100},{60,98}},
            color={0,0,255},
            smooth=Smooth.None)}), Icon(coordinateSystem(preserveAspectRatio=false,
            extent={{-100,-100},{100,100}}), graphics={
          Line(
            points={{10,0},{-10,-20},{-10,20}},
            color={0,0,255},
            smooth=Smooth.None,
            origin={0,-30},
            rotation=90),
          Line(
            points={{0,20},{0,-20}},
            color={0,0,255},
            smooth=Smooth.None,
            origin={0,60},
            rotation=270),
          Line(
            points={{20,-20},{-20,20},{-20,-20}},
            color={0,0,255},
            smooth=Smooth.None,
            origin={0,40},
            rotation=90),
          Ellipse(extent={{40,80},{-40,0}}, lineColor={0,0,255}),
          Ellipse(extent={{40,0},{-40,-80}}, lineColor={0,0,255}),
          Line(
            points={{-60,-100},{-60,-74},{-60,-60},{-40,-40}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{60,-100},{60,-60},{40,-40}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{60,100},{60,60},{40,40}},
            color={0,0,255},
            smooth=Smooth.None),
          Line(
            points={{-60,100},{-60,60},{-40,40}},
            color={0,0,255},
            smooth=Smooth.None)}));
  end ZoneSplitter;

  package BaseClasses
    partial model HydraulicCircuitPartial "Partial for a hydraulic circuit"

      //Extensions
      extends IDEAS.Fluid.Interfaces.PartialFourPortInterface;

      Modelica.Blocks.Interfaces.RealInput ControlInput
        "Control signal for the valve/pump" annotation (Placement(
            transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,114})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                -100,-100},{100,100}}), graphics={Line(
              points={{-100,60},{98,60}},
              color={0,0,255},
              smooth=Smooth.None), Line(
              points={{-102,-60},{102,-60}},
              color={0,0,255},
              smooth=Smooth.None)}), Diagram(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics));
    end HydraulicCircuitPartial;
  end BaseClasses;
end HydraulicCircuits;
