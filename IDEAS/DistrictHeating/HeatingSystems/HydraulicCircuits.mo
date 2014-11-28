within IDEAS.DistrictHeating.HeatingSystems;
package HydraulicCircuits "Collection of basic hydraulic circuits"
  model Mixer
    //Extensions
    extends BaseClasses.HydraulicCircuitPartial(
      redeclare replaceable package Medium1 = IDEAS.Media.Water.Simple,
      redeclare replaceable package Medium2 = IDEAS.Media.Water.Simple,
      from_dp=false);

    //Parameters
    parameter Real mcurve=1.3 "Exponent for heat transfer"
      annotation (Dialog(group="Heating curve"));
    parameter Modelica.SIunits.Temperature TSup_nominal "Supply temperature"
      annotation (Dialog(group="Heating curve"));
    parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30 if minSup
      "Minimum supply temperature if enabled"
      annotation (Dialog(group="Heating curve"));
    parameter Boolean minSup=true
      "true to limit the supply temperature on the lower side"
      annotation (Dialog(group="Heating curve"));
    parameter Modelica.SIunits.Temperature TRet_nominal "Return temperature"
      annotation (Dialog(group="Heating curve"));
    parameter Modelica.SIunits.Temperature TRoo_nominal=293.15
      "Room temperature"
      annotation (Dialog(group="Heating curve"));
    parameter Modelica.SIunits.Temperature TOut_nominal "Outside temperature"
      annotation (Dialog(group="Heating curve"));

    parameter Boolean use_TRoo_in=false
      "Get the room temperature set point from the input connector" annotation (
      Evaluate=true,
      HideResult=true,
      choices(__Dymola_checkBox=true),
      Dialog(group="Heating curve"));
    parameter Modelica.SIunits.Temperature TRoo=293.15
      "Fixed value of room air temperature set point"
      annotation (Evaluate=true, Dialog(enable=not use_TRoo_in), Dialog(group="Heating curve"));
    parameter Modelica.SIunits.TemperatureDifference dTOutHeaBal=8
      "Offset for heating curve"
      annotation (Dialog(group="Heating curve"));

    Fluid.FixedResistances.SplitterFixedResistanceDpM spl(
      redeclare replaceable package Medium = Medium1,
      m_flow_nominal={m1_flow_nominal,m1_flow_nominal,-m1_flow_nominal},
      dp_nominal={-20,20,-20})
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=0,
          origin={12,-60})));
    Fluid.Valves.Thermostatic3WayValve idealCtrlMixer(
      redeclare package Medium = Medium1, m_flow_nominal=m1_flow_nominal)
                                     annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={12,6})));
    IDEAS.Controls.ControlHeating.HeatingCurve heatingCurve(
      m=mcurve,
      dTOutHeaBal=dTOutHeaBal,
      use_TRoo_in=use_TRoo_in,
      minSup=minSup,
      TSup_nominal=TSup_nominal,
      TSupMin=TSupMin,
      TRet_nominal=TRet_nominal,
      TOut_nominal=TOut_nominal)
                        annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={6,48})));
    outer SimInfoManager sim
      annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=sim.Te)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={20,82})));
    Fluid.Sensors.TemperatureTwoPort MixT(redeclare package Medium = Medium1,
        m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{28,-4},{48,16}})));
    Fluid.Sensors.TemperatureTwoPort supplyT(redeclare package Medium = Medium1,
        m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-26,-4},{-6,16}})));
    Fluid.Sensors.TemperatureTwoPort senReturnT(redeclare package Medium =
          Medium1, m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{56,-70},{36,-50}})));
  equation
    connect(spl.port_3, idealCtrlMixer.port_a2) annotation (Line(
        points={{12,-50},{12,-4}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(heatingCurve.TOut, realExpression.y) annotation (Line(
        points={{12,60},{12,68},{20,68},{20,71}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(idealCtrlMixer.port_b, MixT.port_a) annotation (Line(
        points={{22,6},{28,6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(supplyT.port_b, idealCtrlMixer.port_a1) annotation (Line(
        points={{-6,6},{2,6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(heatingCurve.TSup, idealCtrlMixer.TMixedSet) annotation (Line(
        points={{12,37},{12,16}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(u, heatingCurve.TRoo_in) annotation (Line(
        points={{0,114},{0,90},{1.77636e-015,90},{1.77636e-015,59.9}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(MixT.port_b, port_b1) annotation (Line(
        points={{48,6},{60,6},{60,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(port_a2, senReturnT.port_a) annotation (Line(
        points={{100,-60},{56,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senReturnT.port_b, spl.port_1) annotation (Line(
        points={{36,-60},{22,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated2.port_b, supplyT.port_a) annotation (Line(
        points={{-60,60},{-46,60},{-46,6},{-26,6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated1.port_a, spl.port_2) annotation (Line(
        points={{-60,-60},{2,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
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
            fillColor={0,128,255},
            fillPattern=FillPattern.Solid,
            origin={0,50},
            rotation=90),
          Polygon(
            points={{-10,10},{-10,-10},{10,0},{-10,10}},
            lineColor={0,0,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            origin={10,60},
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
            points={{0,40},{0,-60}},
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
      m_flow_nominal=0.1,
      from_dp=from_dp)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  equation
    connect(val.port_b, port_b1) annotation (Line(
        points={{10,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(u, val.y) annotation (Line(
        points={{0,114},{0,72}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(pipe_Insulated2.port_b, val.port_a) annotation (Line(
        points={{-60,60},{-10,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated1.port_a, port_a2) annotation (Line(
        points={{-60,-60},{100,-60}},
        color={0,127,255},
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
    extends BaseClasses.HydraulicCircuitPartial(
      redeclare replaceable package Medium1 = IDEAS.Media.Water.Simple,
      redeclare replaceable package Medium2 = IDEAS.Media.Water.Simple);

    Fluid.Movers.FlowMachine_m_flow fan(
      redeclare package Medium = Medium1,
      m_flow_nominal=m1_flow_nominal,
      addPowerToMedium=false)
      annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  equation
    connect(u, fan.m_flow_in) annotation (Line(
        points={{0,114},{0,72},{-0.2,72}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fan.port_b, port_b1) annotation (Line(
        points={{10,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated2.port_b, fan.port_a) annotation (Line(
        points={{-60,60},{-10,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated1.port_a, port_a2) annotation (Line(
        points={{-60,-60},{100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
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

  model HeatExchanger
    extends BaseClasses.HydraulicCircuitPartial(pipe_Insulated2(m=m/2,
          m_flow_nominal=m1_flow_nominal), pipe_Insulated1(m=m/2,
          m_flow_nominal=m2_flow_nominal));

    //Parameters
    parameter Modelica.SIunits.Pressure p=2
      "Absolute pressure on the secondary side";
    parameter Real efficiency=0.9 "Efficiency of the heat exchanger";
    parameter Modelica.SIunits.PressureDifference dp1_nominal=200
      "Pressure drop on the primary side";
    parameter Modelica.SIunits.PressureDifference dp2_nominal=200
      "Pressure drop on the secondary side";

    //Components
    Fluid.HeatExchangers.ConstantEffectiveness hex(
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium1,
      m1_flow_nominal=m1_flow_nominal,
      m2_flow_nominal=m1_flow_nominal,
      eps=efficiency,
      dp1_nominal=dp1_nominal,
      dp2_nominal=dp2_nominal)
                       annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=270,
          origin={0,0})));
    Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium = Medium1)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={40,34})));
    Fluid.Sensors.TemperatureTwoPort senSupplyT(redeclare package Medium =
          Medium1, m_flow_nominal=m1_flow_nominal)
      annotation (Placement(transformation(extent={{-34,0},{-14,20}})));
    Direct direct(
      redeclare package Medium1 = Medium1,
      redeclare package Medium2 = Medium1,
      m1_flow_nominal=m1_flow_nominal,
      m2_flow_nominal=m2_flow_nominal,
      m=m/2)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Blocks.Interfaces.RealOutput supplyT
      "Temperature of the supply line on the primary side" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={40,108})));
    Modelica.Blocks.Interfaces.RealOutput senM "Massflow at the secondary side"
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,106})));
  equation
    connect(senMasFlo.port_b, port_b1) annotation (Line(
        points={{50,34},{74,34},{74,60},{100,60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(direct.port_b1, senSupplyT.port_a) annotation (Line(
        points={{-40,6},{-36,6},{-36,10},{-34,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(u, direct.u) annotation (Line(
        points={{0,114},{0,80},{-50,80},{-50,11.4}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(senSupplyT.T, supplyT) annotation (Line(
        points={{-24,21},{-24,72},{40,72},{40,108}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(senSupplyT.port_b, hex.port_a1) annotation (Line(
        points={{-14,10},{-6,10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hex.port_b2, senMasFlo.port_a) annotation (Line(
        points={{6,10},{6,34},{30,34}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hex.port_a2, port_a2) annotation (Line(
        points={{6,-10},{6,-60},{100,-60}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(direct.port_a2, hex.port_b1) annotation (Line(
        points={{-40,-6},{-36,-6},{-36,-10},{-6,-10}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated2.port_b, direct.port_a1) annotation (Line(
        points={{-60,60},{-56,60},{-56,20},{-80,20},{-80,6},{-60,6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated1.port_a, direct.port_b2) annotation (Line(
        points={{-60,-60},{-48,-60},{-48,-40},{-80,-40},{-80,-6},{-60,-6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senMasFlo.m_flow, senM) annotation (Line(
        points={{40,45},{40,60},{60,60},{60,80},{80,80},{80,106}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
            extent={{-42,76},{44,-76}},
            lineColor={0,128,255},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid), Line(
            points={{-42,76},{44,-76}},
            color={0,0,0},
            smooth=Smooth.None),
          Polygon(
            points={{-42,76},{-42,-76},{44,-76},{-42,76}},
            lineColor={0,128,255},
            smooth=Smooth.None,
            fillColor={255,255,255},
            fillPattern=FillPattern.Forward)}));
  end HeatExchanger;

  model ZoneSplitter
    "Model to split a fluid inlet into multiple outlets and back"

    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium "Medium 1 in the component";

    //Parameters
    parameter Integer n(min=1) "Number of outgoing connections";
    parameter Modelica.SIunits.MassFlowRate m_flow_nominal "Nominal flow rate";
    parameter Modelica.SIunits.Volume V "Volume of the piping";

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
    Fluid.MixingVolumes.MixingVolume vol(
      redeclare package Medium = Medium,
      m_flow_nominal=m_flow_nominal,
      nPorts=n+1,
      V=V)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={50,14})));
  equation
    for i in 1:n loop
      connect(port_bN[i], port_a);
    end for;

    connect(port_aN, vol.ports[1:n]);
    connect(port_b, vol.ports[end]);

    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={Line(
            points={{-60,-100},{-60,102},{-60,100}},
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
      extends IDEAS.Fluid.Interfaces.PartialFourPortInterface(
        redeclare replaceable package Medium1 = IDEAS.Media.Water.Simple,
        redeclare replaceable package Medium2 = IDEAS.Media.Water.Simple);
      //Parameters
      parameter Boolean from_dp=true;
      parameter Modelica.SIunits.Mass m(start=1)=1
        "Mass of medium in the return and supply pipe";
      parameter SI.ThermalConductance UA=10
        "Thermal conductance of the insulation";

      Modelica.Blocks.Interfaces.RealInput u "Control input signal"
                                           annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,114})));
      Fluid.FixedResistances.Pipe_Insulated pipe_Insulated2(
        redeclare package Medium = Medium1,
        m=m,
        UA=UA,
        m_flow_nominal=m1_flow_nominal)
                                       annotation (Placement(transformation(
            extent={{-10,4},{10,-4}},
            rotation=0,
            origin={-70,60})));
      Fluid.FixedResistances.Pipe_Insulated pipe_Insulated1(
        redeclare package Medium = Medium1,
        m=m,
        UA=UA,
        m_flow_nominal=m2_flow_nominal)
                                       annotation (Placement(transformation(
            extent={{-10,4},{10,-4}},
            rotation=180,
            origin={-70,-60})));
    equation
      connect(port_a1, pipe_Insulated2.port_a) annotation (Line(
          points={{-100,60},{-80,60}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(port_b2, pipe_Insulated1.port_b) annotation (Line(
          points={{-100,-60},{-80,-60}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-100,60},{98,60}},
              color={0,0,255},
              smooth=Smooth.None),
            Line(
              points={{-102,-60},{102,-60}},
              color={0,0,255},
              smooth=Smooth.None)}), Diagram(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics));
    end HydraulicCircuitPartial;
  end BaseClasses;
end HydraulicCircuits;
