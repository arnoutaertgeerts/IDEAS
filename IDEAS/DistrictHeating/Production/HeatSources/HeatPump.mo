within IDEAS.DistrictHeating.Production.HeatSources;
model HeatPump
  //Extensions
  extends BaseClasses.PartialHeatSource;

  parameter IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump data;

  //Variables
  Modelica.SIunits.Power PEl;
  Real cop;

  //Components
  Modelica.Blocks.Tables.CombiTable2D copTable(
    table=data.cop)
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));
  Modelica.Blocks.Tables.CombiTable2D powerTable(
    table=data.power)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
        transformation(extent={{-28,66},{12,106}}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-2,88})));

equation
  //Calculation of the heat provided by the heatpump
  cop = if on then  copTable.y else 1;
  PEl = if on then  powerTable.y * scaler else 0;
  heatPort.Q_flow=-PEl*cop;

  //Approximation!!
  powerTable.u2 = sim.Te;
  copTable.u2 = sim.Te;

  //Tin
  connect(THxIn, powerTable.u1) annotation (Line(
      points={{-108,-40},{-40,-40},{-40,-14},{-12,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(copTable.u1, powerTable.u1) annotation (Line(
      points={{-12,26},{-26,26},{-26,26},{-40,26},{-40,-14},{-12,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end HeatPump;
