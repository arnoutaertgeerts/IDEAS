within IDEAS.DistrictHeating;
package Examples
  model SeriesGrid "District heating grid with buildings connected in series"
    Interfaces.Network network(
      redeclare Substations.SingleHeatExchanger endStation,
      redeclare Substations.SingleHeatExchanger substations,
      redeclare Production.Boiler production(boiler(from_dp=true)))
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
  end SeriesGrid;

  model TestBoiler "Simple test example for boiler"
    IDEAS.DistrictHeating.Production.ModulatingProduction modulatingProduction(
      QNom=100,
      m_flow_nominal=100,
      redeclare IDEAS.DistrictHeating.Production.Data.GenericBoiler
        productionData,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater)
      annotation (Placement(transformation(extent={{-42,22},{-22,44}})));
    IDEAS.Fluid.FixedResistances.Pipe_Insulated pipe_Insulated(
      UA=10,
      m_flow_nominal=0.1,
      redeclare package Medium =
          Modelica.Media.Water.ConstantPropertyLiquidWater,
      m=1) annotation (Placement(transformation(extent={{0,18},{20,26}})));
    Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
          293.15)
      annotation (Placement(transformation(extent={{-28,-22},{-8,-2}})));
    Modelica.Blocks.Sources.Constant const(k=300)
      annotation (Placement(transformation(extent={{-82,44},{-62,64}})));
  equation
    connect(modulatingProduction.port_b, pipe_Insulated.port_a) annotation (
        Line(
        points={{-22,36},{-12,36},{-12,22},{0,22}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipe_Insulated.port_b, modulatingProduction.port_a) annotation (
        Line(
        points={{20,22},{0,22},{0,28},{-22,28}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(fixedTemperature.port, pipe_Insulated.heatPort) annotation (Line(
        points={{-8,-12},{2,-12},{2,18},{10,18}},
        color={191,0,0},
        smooth=Smooth.None));
    connect(const.y, modulatingProduction.TSet) annotation (Line(
        points={{-61,54},{-48,54},{-48,44},{-33,44}},
        color={0,0,127},
        smooth=Smooth.None));
    connect(fixedTemperature.port, modulatingProduction.heatPort) annotation (
        Line(
        points={{-8,-12},{-22,-12},{-22,22},{-35,22}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{
              -100,-100},{100,100}}), graphics));
  end TestBoiler;
end Examples;
