within IDEAS;
package DistrictHeating "Models specific for district heating"
  package Substations
    model HXWithBypass
      //Extensions
      extends DistrictHeating.Interfaces.Baseclasses.Substation(
        flowPort_supply_out(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater),
        flowPort_return_in(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater),
        flowPort_b1(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater),
        flowPort_a1(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater),
        flowPort_supply_in(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater),
        flowPort_return_out(redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater));

      //Components
      replaceable IDEAS.Fluid.HeatExchangers.ConstantEffectiveness
        staticFourPortHeatMassExchanger(
        redeclare package Medium1 =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        redeclare package Medium2 =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m1_flow_nominal=0.1,
        m2_flow_nominal=0.1,
        dp1_nominal=2,
        dp2_nominal=2) constrainedby
        IDEAS.Fluid.Interfaces.StaticFourPortHeatMassExchanger(
        redeclare package Medium1 =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        redeclare package Medium2 =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m1_flow_nominal=0.1,
        m2_flow_nominal=0.1,
        dp1_nominal=2,
        dp2_nominal=2) "Building substation"
        annotation (Placement(transformation(extent={{-10,66},{10,86}})));
      IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl1(
        m_flow_nominal={0.1,-0.1,-0.1},
        dp_nominal={20,20,10},
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        "Splitter for bypass"
        annotation (Placement(transformation(extent={{-16,-10},{-36,-30}})));
      IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
        m_flow_nominal={0.1,-0.1,-0.1},
        dp_nominal={20,20,10},
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater)
        "Splitter for bypass"
        annotation (Placement(transformation(extent={{80,30},{60,10}})));
      replaceable IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m_flow_nominal=0.2,
        m=5,
        UA=10) "Insulated pipe with heat exchange to the outside"
        annotation (
          Placement(transformation(
            extent={{-10,-4},{10,4}},
            rotation=180,
            origin={-66,-20})));

      replaceable IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m_flow_nominal=0.2,
        UA=10,
        m=5) "Insulated pipe with heat exchange to the outside"
        annotation (
          Placement(transformation(
            extent={{-10,-4},{10,4}},
            rotation=180,
            origin={-66,20})));

      replaceable IDEAS.Fluid.Movers.Pump pump(useInput=true,
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m_flow_nominal=0.1) "Pump of the heat exchanger"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,44})));

      Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature
        prescribedTemperature "Ambient Temperature"
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-66,-54})));

      Modelica.Fluid.Sensors.TemperatureTwoPort temperature(redeclare package
          Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
        "Sensor of the return temperature" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-26,44})));
      IDEAS.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI)
        annotation (Placement(transformation(extent={{30,34},{50,54}})));
      Modelica.Blocks.Sources.Constant const(k=273.15 + 50)
        "Temperature below wich the pump should be on"
        annotation (Placement(transformation(extent={{-6,34},{14,54}})));
    equation
      //Connections
      connect(flowPort_b1, staticFourPortHeatMassExchanger.port_a1) annotation (
          Line(
          points={{-20,100},{-20,82},{-10,82}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(staticFourPortHeatMassExchanger.port_b1, flowPort_a1) annotation (
          Line(
          points={{10,82},{20,82},{20,100}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(spl1.port_2, pipe_Insulated.port_a) annotation (Line(
          points={{-36,-20},{-56,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(spl2.port_2, pipe_Insulated1.port_a) annotation (Line(
          points={{60,20},{-56,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe_Insulated.heatPort, prescribedTemperature.port) annotation (Line(
          points={{-66,-16},{-66,-8},{-44,-8},{-44,-30},{-66,-30},{-66,-44}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(pipe_Insulated1.heatPort, prescribedTemperature.port) annotation (
          Line(
          points={{-66,24},{-66,40},{-44,40},{-44,-30},{-66,-30},{-66,-44}},
          color={191,0,0},
          smooth=Smooth.None));
      connect(prescribedTemperature.T, u) annotation (Line(
          points={{-66,-66},{-66,-80},{0,-80},{0,-106}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(flowPort_supply_in, flowPort_supply_in) annotation (Line(
          points={{100,20},{100,20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spl2.port_1, flowPort_supply_in) annotation (Line(
          points={{80,20},{100,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe_Insulated1.port_b, flowPort_supply_out) annotation (Line(
          points={{-76,20},{-100,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(spl1.port_1, flowPort_return_out) annotation (Line(
          points={{-16,-20},{100,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(pipe_Insulated.port_b, flowPort_return_in) annotation (Line(
          points={{-76,-20},{-100,-20}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(staticFourPortHeatMassExchanger.port_a2, pump.port_b) annotation (
          Line(
          points={{10,70},{70,70},{70,54}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(spl2.port_3, pump.port_a) annotation (Line(
          points={{70,30},{70,34}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(staticFourPortHeatMassExchanger.port_b2, temperature.port_a)
        annotation (Line(
          points={{-10,70},{-26,70},{-26,54}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperature.T, conPID.u_m) annotation (Line(
          points={{-15,44},{-10,44},{-10,24},{40,24},{40,32}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(conPID.y, pump.m_flowSet) annotation (Line(
          points={{51,44},{59.6,44}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(conPID.u_s, const.y) annotation (Line(
          points={{28,44},{15,44}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(temperature.port_b, spl1.port_3) annotation (Line(
          points={{-26,34},{-26,-10}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end HXWithBypass;
  annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            fillPattern=FillPattern.None,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Polygon(points={{-70,26},{68,-44},{68,26},{2,-10},{-70,-42},{-70,26}},
              lineColor={0,0,0}),
          Line(points={{2,42},{2,-10}}, color={0,0,0}),
          Rectangle(
            extent={{-18,50},{22,42}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}));
  end Substations;

  package Production "Production units for district heating"
    model BoilerWithPump "Boiler for production of hot water"

      //Extensions
      extends DistrictHeating.Interfaces.Baseclasses.Production(flowPort_supply(
            redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater), flowPort_return(
            redeclare package Medium =
              Modelica.Media.Water.ConstantPropertyLiquidWater));

      IDEAS.Fluid.Production.Boiler boiler(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        QNom=10000,
        mWater=50,
        m_flow_nominal=0.1) annotation (Placement(transformation(
            extent={{-10,-11},{10,11}},
            rotation=270,
            origin={-2,27})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=350)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={32,28})));
      IDEAS.Fluid.Movers.Pump pump(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater, m_flow_nominal=0.2)
        annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
    equation
      connect(realExpression.y,boiler. TSet) annotation (Line(
          points={{21,28},{10,28},{10,27}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boiler.port_b, flowPort_supply) annotation (Line(
          points={{2,16},{2,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowPort_return, pump.port_a) annotation (Line(
          points={{-100,0},{-48,0}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(boiler.port_a, pump.port_b) annotation (Line(
          points={{-6,16},{-18,16},{-18,0},{-28,0}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end BoilerWithPump;
  annotation (Icon(graphics={
          Rectangle(
            lineColor={200,200,200},
            fillColor={248,248,248},
            fillPattern=FillPattern.HorizontalCylinder,
            extent={{-100,-100},{100,100}},
            radius=25.0),
          Rectangle(
            lineColor={128,128,128},
            fillPattern=FillPattern.None,
            extent={{-100,-100},{100,100}},
            radius=25.0),
        Polygon(
          origin={11.533,37.938},
          lineColor = {0,128,255},
          fillColor = {0,128,255},
          fillPattern = FillPattern.Solid,
          points = {{-80,10},{-60,-10},{-80,-30},{-20,-30},{0,-10},{-20,10},{-80,10}}),
        Polygon(
          origin={11.533,37.938},
          lineColor = {255,0,0},
          fillColor = {255,0,0},
          fillPattern = FillPattern.Solid,
          points = {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}}),
        Polygon(
          origin={11.533,37.938},
          lineColor = {255,128,0},
          fillColor = {255,128,0},
          fillPattern = FillPattern.Solid,
          points = {{-20,10},{0,-10},{-20,-30},{40,-30},{60,-10},{40,10},{-20,10}})}));
  end Production;

  package Interfaces "Interfaces for district heating network"

    extends Modelica.Icons.InterfacesPackage;

    partial package Baseclasses
      "Baseclasses for the construction of a district heating grid"

      extends Modelica.Icons.InterfacesPackage;

      partial model Substation "Interface for a local substation"

        //Connectors
        IDEAS.Fluid.Interfaces.FlowPort_b flowPort_b1(redeclare package Medium
            = Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Flowport return from to the building"
          annotation (Placement(transformation(extent={{-30,90},{-10,110}})));
        IDEAS.Fluid.Interfaces.FlowPort_a flowPort_a1(redeclare package Medium
            = Modelica.Media.Water.ConstantPropertyLiquidWater)
          "Flowport supply to the building"
          annotation (Placement(transformation(extent={{10,90},{30,110}})));

        Modelica.Blocks.Interfaces.RealInput u "Outside temperature connector"
          annotation (Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-106})));
        IDEAS.Fluid.Interfaces.FlowPort_b flowPort_supply_out
          "Supply line out connection"
          annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
        IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply_in
          "Supply line in connection"
          annotation (Placement(transformation(extent={{90,10},{110,30}})));
        IDEAS.Fluid.Interfaces.FlowPort_a flowPort_return_in
          "Return line in connection"
          annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
        IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return_out
          "Return line out connection"
          annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(graphics={
              Line(
                points={{0,12},{7.3479e-016,-24}},
                color={0,0,255},
                smooth=Smooth.None,
                origin={-82,-20},
                rotation=90),
              Rectangle(
                extent={{-58,60},{62,-60}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-58,72},{62,48}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{-58,-48},{62,-72}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-20,62},{-20,98}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{20,62},{20,98}},
                color={0,0,255},
                smooth=Smooth.None),
              Line(
                points={{0,12},{7.3479e-016,-24}},
                color={0,0,255},
                smooth=Smooth.None,
                origin={-82,20},
                rotation=90),
              Line(
                points={{0,12},{7.3479e-016,-24}},
                color={0,0,255},
                smooth=Smooth.None,
                origin={74,20},
                rotation=90),
              Line(
                points={{0,12},{7.3479e-016,-24}},
                color={0,0,255},
                smooth=Smooth.None,
                origin={74,-20},
                rotation=90)}));
      end Substation;

      partial model Production
        "Interface for a district heating production unit"

        IDEAS.Fluid.Interfaces.FlowPort_b flowPort_return
          "Return side of the production (cold water)"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        IDEAS.Fluid.Interfaces.FlowPort_a flowPort_supply
          "Supply flow port (hot water)"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                  -100},{100,100}}), graphics), Icon(graphics={Line(
                points={{-100,0},{-80,0},{-60,40},{-40,-40},{-20,40},{0,-40},{20,40},
                    {40,-40},{60,40},{80,0},{100,0},{98,0}},
                color={0,0,255},
                smooth=Smooth.None)}));
      end Production;
    end Baseclasses;

    model Network "Interface for a district heating network"

      replaceable Baseclasses.Building building(DH=true)
        annotation (Placement(transformation(extent={{-40,14},{-20,34}})));
      replaceable Baseclasses.Building building1(DH=true)
        annotation (Placement(transformation(extent={{-76,14},{-56,34}})));
      replaceable Baseclasses.Substation substation
        annotation (Placement(transformation(extent={{-76,-22},{-56,-2}})));
      replaceable Baseclasses.Substation substation1
        annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
      replaceable Baseclasses.Production production annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={44,-10})));
      Modelica.Blocks.Sources.Constant TAmb
        "Ambient Temperature for pipe losses to the ground"
        annotation (Placement(transformation(extent={{-88,-72},{-68,-52}})));
      IDEAS.Fluid.Sources.FixedBoundary bou(nPorts=1, redeclare package Medium
          = Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,40})));

        inner IDEAS.SimInfoManager sim
        annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
    equation
      connect(substation.flowPort_supply_in, substation1.flowPort_supply_out)
        annotation (Line(
          points={{-56,-10},{-40,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(substation.flowPort_return_out, substation1.flowPort_return_in)
        annotation (Line(
          points={{-56,-14},{-40,-14}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(substation.flowPort_supply_out, substation.flowPort_return_in)
        annotation (Line(
          points={{-76,-10},{-84,-10},{-84,-14},{-76,-14}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(production.flowPort_supply, substation1.flowPort_supply_in)
        annotation (Line(
          points={{44,0},{44,16},{0,16},{0,-10},{-20,-10},{-20,-10}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(substation1.flowPort_return_out, production.flowPort_return)
        annotation (Line(
          points={{-20,-14},{-20,-14},{0,-14},{0,-36},{44,-36},{44,-20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(substation.u, substation1.u) annotation (Line(
          points={{-66,-22.6},{-66,-40},{-30,-40},{-30,-40},{-30,-22},{-30,-22},{
              -30,-22.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(TAmb.y, substation1.u) annotation (Line(
          points={{-67,-62},{-48,-62},{-48,-40},{-30,-40},{-30,-22.6}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(building1.port_return, substation.flowPort_b1) annotation (Line(
          points={{-67.6,14},{-68,14},{-68,-2}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(building1.port_supply, substation.flowPort_a1) annotation (Line(
          points={{-64.7,14.1},{-64.7,14},{-64,14},{-64,-2}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(building.port_return, substation1.flowPort_b1) annotation (Line(
          points={{-31.6,14},{-32,14},{-32,-2}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(building.port_supply, substation1.flowPort_a1) annotation (Line(
          points={{-28.7,14.1},{-28.7,14},{-28,14},{-28,-2}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(bou.ports[1], substation1.flowPort_supply_in) annotation (Line(
          points={{20,30},{20,16},{0,16},{0,-10},{-20,-10}},
          color={0,127,255},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics), Icon(coordinateSystem(
              preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              extent={{-60,80},{-40,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,80},{10,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{40,80},{60,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,80},{10,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={0,50},
              rotation=90),
            Rectangle(
              extent={{-10,80},{10,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={0,5.32907e-015},
              rotation=90),
            Rectangle(
              extent={{-10,80},{10,-80}},
              lineColor={0,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              origin={0,-50},
              rotation=90)}));
    end Network;
  end Interfaces;

  model Example

    inner IDEAS.SimInfoManager sim(occBeh=false, DHW=false)
      annotation (Placement(transformation(extent={{-92,74},{-72,94}})));
    inner Modelica.Fluid.System system
      annotation (Placement(transformation(extent={{-68,76},{-48,96}})));
    IDEAS.Interfaces.Building building(
      redeclare IDEAS.HeatingSystems.Examples.DummyBuilding building(nZones=1,
          nEmb=0),
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem,
      redeclare IDEAS.Buildings.Validation.BaseClasses.Occupant.None occupant,
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true) annotation (Placement(transformation(extent={{-16,6},{4,26}})));
    IDEAS.DistrictHeating.Substations.HXWithBypass hXWithBypass
      annotation (Placement(transformation(extent={{-18,-26},{2,-6}})));
    IDEAS.DistrictHeating.Production.BoilerWithPump boilerWithPump
      annotation (Placement(transformation(extent={{26,-24},{46,-4}})));
    IDEAS.Fluid.Sources.FixedBoundary bou(
      nPorts=1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      p=300000,
      use_T=false)
      annotation (Placement(transformation(extent={{-58,-42},{-38,-22}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=273)
      annotation (Placement(transformation(extent={{-38,-80},{-18,-60}})));
  equation
    connect(hXWithBypass.flowPort_b1, building.port_return) annotation (Line(
        points={{-10,-6},{-10,6},{-7.6,6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_a1, building.port_supply) annotation (Line(
        points={{-6,-6},{-4.7,-6},{-4.7,6.1}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_in, boilerWithPump.flowPort_return)
      annotation (Line(
        points={{2,-14},{26,-14}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(boilerWithPump.flowPort_supply, hXWithBypass.flowPort_return_out)
      annotation (Line(
        points={{46,-14},{50,-14},{50,-18},{2,-18}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_out, hXWithBypass.flowPort_return_in)
      annotation (Line(
        points={{-18,-14},{-18,-18}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(bou.ports[1], hXWithBypass.flowPort_return_in) annotation (Line(
        points={{-38,-32},{-30,-32},{-30,-18},{-18,-18}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(realExpression.y, hXWithBypass.u) annotation (Line(
        points={{-17,-70},{-8,-70},{-8,-26.6}},
        color={0,0,127},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end Example;
end DistrictHeating;
