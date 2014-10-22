within IDEAS;
package DistrictHeating "Models specific for district heating"
  package Substations
    model HXWithBypass
      import Buildings;
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
      IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl1(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m_flow_nominal={0.25,-0.25,-0.25},
        dp_nominal={20,-20,-20}) "Splitter for bypass"
        annotation (Placement(transformation(extent={{-16,-10},{-36,-30}})));
      IDEAS.Fluid.FixedResistances.SplitterFixedResistanceDpM spl2(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m_flow_nominal={0.25,-0.25,-0.25},
        dp_nominal={20,-20,-20}) "Splitter for bypass"
        annotation (Placement(transformation(extent={{80,30},{60,10}})));

      IDEAS.Controls.Continuous.LimPID conPID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=100,
        Ti=30)
        annotation (Placement(transformation(extent={{16,34},{36,54}})));
      Fluid.Actuators.Valves.TwoWayLinear val(
        redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m_flow_nominal=0.1,
        dpValve_nominal=20)                   annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={70,44})));
      Modelica.Fluid.Sensors.TemperatureTwoPort temperature1(
                                                            redeclare package
          Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
        "Sensor of the return temperature" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={20,82})));
      Controls.ControlHeating.HeatingCurve heatingCurve
        annotation (Placement(transformation(extent={{-66,28},{-46,48}})));
      outer SimInfoManager sim
        annotation (Placement(transformation(extent={{-98,80},{-78,100}})));
      Modelica.Fluid.Sensors.TemperatureTwoPort Tsupply(redeclare package
          Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
        "Sensor of the return temperature" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-4,20})));
      Modelica.Fluid.Sensors.TemperatureTwoPort TReturn(redeclare package
          Medium = Modelica.Media.Water.ConstantPropertyLiquidWater)
        "Sensor of the return temperature" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={14,-20})));
      Fluid.HeatExchangers.ConstantEffectiveness hex(
        redeclare package Medium1 =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        redeclare package Medium2 =
            Modelica.Media.Water.ConstantPropertyLiquidWater,
        m1_flow_nominal=0.25,
        m2_flow_nominal=0.25,
        dp1_nominal=200,
        dp2_nominal=200)
        annotation (Placement(transformation(extent={{-14,56},{6,76}})));
      Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium =
            Modelica.Media.Water.ConstantPropertyLiquidWater) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-20,82})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
        annotation (Placement(transformation(extent={{42,78},{62,98}})));
      Modelica.Blocks.Math.BooleanToReal booleanToReal
        annotation (Placement(transformation(extent={{72,78},{92,98}})));
      Modelica.Blocks.Math.Product product
        annotation (Placement(transformation(extent={{108,60},{128,80}})));
    equation
      //Connections
      connect(flowPort_supply_in, flowPort_supply_in) annotation (Line(
          points={{100,20},{100,20}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(spl2.port_1, flowPort_supply_in) annotation (Line(
          points={{80,20},{100,20}},
          color={0,127,255},
          smooth=Smooth.None));

      connect(spl1.port_2, flowPort_return_in) annotation (Line(
          points={{-36,-20},{-100,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(spl2.port_3, val.port_a) annotation (Line(
          points={{70,30},{70,34}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowPort_a1, temperature1.port_a) annotation (Line(
          points={{20,100},{20,92}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(conPID.u_s, heatingCurve.TSup) annotation (Line(
          points={{14,44},{-45,44}},
          color={0,0,127},
          smooth=Smooth.None));

      heatingCurve.TOut = sim.Te;
      connect(spl2.port_2, Tsupply.port_b) annotation (Line(
          points={{60,20},{6,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(Tsupply.port_a, flowPort_supply_out) annotation (Line(
          points={{-14,20},{-100,20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(spl1.port_1, TReturn.port_a) annotation (Line(
          points={{-16,-20},{4,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(TReturn.port_b, flowPort_return_out) annotation (Line(
          points={{24,-20},{100,-20}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(temperature1.port_b, hex.port_b1) annotation (Line(
          points={{20,72},{6,72}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(hex.port_b2, spl1.port_3) annotation (Line(
          points={{-14,60},{-26,60},{-26,-10}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(hex.port_a2, val.port_b) annotation (Line(
          points={{6,60},{70,60},{70,54}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowPort_b1, senMasFlo1.port_a) annotation (Line(
          points={{-20,100},{-20,92}},
          color={0,0,0},
          smooth=Smooth.None));
      connect(senMasFlo1.port_b, hex.port_a1) annotation (Line(
          points={{-20,72},{-14,72}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(senMasFlo1.m_flow, greaterThreshold.u) annotation (Line(
          points={{-9,82},{-4,82},{-4,88},{40,88}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(greaterThreshold.y, booleanToReal.u) annotation (Line(
          points={{63,88},{70,88}},
          color={255,0,255},
          smooth=Smooth.None));
      connect(temperature1.T, conPID.u_m) annotation (Line(
          points={{31,82},{38,82},{38,64},{10,64},{10,22},{26,22},{26,32}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(conPID.y, product.u2) annotation (Line(
          points={{37,44},{48,44},{48,64},{106,64}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(booleanToReal.y, product.u1) annotation (Line(
          points={{93,88},{96,88},{96,84},{106,84},{106,76}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(val.y, product.y) annotation (Line(
          points={{58,44},{56,44},{56,68},{92,68},{92,52},{134,52},{134,70},{
              129,70}},
          color={0,0,127},
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
    model Boiler "Boiler for production of hot water"

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
    equation
      connect(realExpression.y,boiler. TSet) annotation (Line(
          points={{21,28},{10,28},{10,27}},
          color={0,0,127},
          smooth=Smooth.None));
      connect(boiler.port_b, flowPort_supply) annotation (Line(
          points={{2,16},{2,0},{100,0}},
          color={0,127,255},
          smooth=Smooth.None));
      connect(flowPort_return, boiler.port_a) annotation (Line(
          points={{-100,0},{-6,0},{-6,16}},
          color={0,0,0},
          smooth=Smooth.None));
      annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics));
    end Boiler;
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
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.Occupants.Standards.None occupant(TSet_val=296.15),
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15))
               annotation (Placement(transformation(extent={{-18,22},{2,42}})));
    IDEAS.DistrictHeating.Substations.HXWithBypass hXWithBypass(heatingCurve(
        dTOutHeaBal=0,
        TSup_nominal=343.15,
        TSupMin=318.15,
        TRet_nominal=323.15,
        TOut_nominal=273.15))
      annotation (Placement(transformation(extent={{-18,-26},{2,-6}})));
    IDEAS.DistrictHeating.Production.Boiler boiler(boiler(dp_nominal=10000, QNom=30000),
        realExpression(y=343)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={80,-16})));
    Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      dp_nominal=10000,
      m_flow_nominal=0.25,
      UA=250,
      from_dp=true)
              annotation (Placement(transformation(extent={{20,-2},{40,6}})));

    Fluid.FixedResistances.Pipe_Insulated pipe_Insulated1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      dp_nominal=10000,
      m_flow_nominal=0.25,
      UA=250,
      from_dp=true)
              annotation (Placement(transformation(extent={{22,-34},{42,-26}})));

    Fluid.Movers.FlowMachine_dp fan1(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      motorCooledByFluid=false,
      m_flow_nominal=0.5)            annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=180,
          origin={62,2})));

    IDEAS.Interfaces.Building building1(
      redeclare Occupants.Standards.None                             occupant(TSet_val=
            296.15),
      redeclare IDEAS.Interfaces.BaseClasses.CausalInhomeFeeder inHomeGrid,
      redeclare IDEAS.VentilationSystems.None ventilationSystem,
      DH=true,
      redeclare Buildings.Examples.BaseClasses.structure building,
      redeclare IDEAS.HeatingSystems.Heating_Radiators_DH heatingSystem(
          dTSupRetNom=20, TSupNom=318.15))
               annotation (Placement(transformation(extent={{-78,22},{-58,42}})));
    IDEAS.DistrictHeating.Substations.HXWithBypass hXWithBypass1(
        heatingCurve(
        TSup_nominal=343.15,
        TSupMin=318.15,
        TRet_nominal=323.15,
        TOut_nominal=263.15))
      annotation (Placement(transformation(extent={{-78,-26},{-58,-6}})));
    Fluid.FixedResistances.Pipe_Insulated pipe_Insulated2(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m_flow_nominal=0.25,
      UA=50,
      from_dp=true,
      dp_nominal=10)
             annotation (Placement(transformation(extent={{-46,-10},{-26,-2}})));

    Fluid.FixedResistances.Pipe_Insulated pipe_Insulated3(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m_flow_nominal=0.25,
      UA=50,
      from_dp=true,
      dp_nominal=10)
             annotation (Placement(transformation(extent={{-46,-30},{-26,-22}})));

    Modelica.Blocks.Sources.Constant const(k=100000)
      annotation (Placement(transformation(extent={{28,-70},{48,-50}})));
    Fluid.Sources.FixedBoundary bou(
      nPorts=1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      p=100000,
      use_T=false)
      annotation (Placement(transformation(extent={{-20,-68},{0,-48}})));

    Fluid.FixedResistances.Pipe_Insulated pipe_Insulated4(
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m_flow_nominal=0.25,
      UA=50,
      from_dp=true,
      dp_nominal=10000)
             annotation (Placement(transformation(extent={{-10,-4},{10,4}},
          rotation=270,
          origin={-104,-18})));
  equation
    connect(hXWithBypass.flowPort_b1, building.port_return) annotation (Line(
        points={{-10,-6},{-10,22},{-9.6,22}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_a1, building.port_supply) annotation (Line(
        points={{-6,-6},{-6.7,-6},{-6.7,22.1}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_in, pipe_Insulated.port_a) annotation (
        Line(
        points={{2,-14},{2,2},{20,2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_out, pipe_Insulated1.port_a) annotation (
       Line(
        points={{2,-18},{2,-30},{22,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(boiler.flowPort_return, pipe_Insulated1.port_b) annotation (Line(
        points={{80,-26},{80,-30},{42,-30}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(pipe_Insulated.port_b, fan1.port_b) annotation (Line(
        points={{40,2},{52,2}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(boiler.flowPort_supply, fan1.port_a) annotation (Line(
        points={{80,-6},{80,2},{72,2}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_b1, building1.port_return) annotation (Line(
        points={{-70,-6},{-70,22},{-69.6,22}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(building1.port_supply, hXWithBypass1.flowPort_a1) annotation (Line(
        points={{-66.7,22.1},{-66.7,-6},{-66,-6}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_supply_in, pipe_Insulated2.port_a) annotation (
       Line(
        points={{-58,-14},{-52,-14},{-52,-6},{-46,-6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_supply_out, pipe_Insulated2.port_b) annotation (
       Line(
        points={{-18,-14},{-22,-14},{-22,-6},{-26,-6}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass1.flowPort_return_out, pipe_Insulated3.port_a)
      annotation (Line(
        points={{-58,-18},{-52,-18},{-52,-26},{-46,-26}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(hXWithBypass.flowPort_return_in, pipe_Insulated3.port_b) annotation (
        Line(
        points={{-18,-18},{-22,-18},{-22,-26},{-26,-26}},
        color={0,0,0},
        smooth=Smooth.None));
    connect(fan1.dp_in, const.y) annotation (Line(
        points={{62.2,-10},{62,-10},{62,-60},{49,-60}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(pipe_Insulated1.port_a, bou.ports[1]) annotation (Line(
        points={{22,-30},{12,-30},{12,-58},{0,-58}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated4.port_a, hXWithBypass1.flowPort_supply_out)
      annotation (Line(
        points={{-104,-8},{-78,-8},{-78,-14}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated4.port_b, hXWithBypass1.flowPort_return_in)
      annotation (Line(
        points={{-104,-28},{-78,-28},{-78,-18}},
        color={0,127,255},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,
              -100},{100,100}}),      graphics), Icon(coordinateSystem(extent={
              {-140,-100},{100,100}})));
  end Example;
end DistrictHeating;
