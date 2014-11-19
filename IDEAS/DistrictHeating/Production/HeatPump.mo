within IDEAS.DistrictHeating.Production;
model HeatPump
  //Extensions
  extends IDEAS.DistrictHeating.Production.BaseClasses.PartialHeatPump(
      QNomRef=data.QNomRef,
      TMax=data.TMax,
      TMin=data.TMin,
      modulationMin=data.modulationMin,
      modulationStart=data.modulationStart,
      m_flow_nominal=data.m_flow_nominal,
      m_flow_nominal_brine=data.m_flow_nominal_brine,
      mBrine=data.mBrine,
      redeclare HeatSources.HeatPump heatSource(
        redeclare package MediumBrine = MediumBrine,
        redeclare package MediumFluid = MediumFluid,
        copData=data.copData,
        powerData=data.powerData));

  replaceable BaseClasses.PartialHeatPumpData data
    annotation (Placement(transformation(extent={{-2,96},{18,116}})));
  Modelica.Blocks.Interfaces.BooleanInput on annotation (Placement(
        transformation(extent={{-128,60},{-88,100}}),
                                                    iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-60,114})));
equation
  PEl = heatSource.PEl;
  PFuel = 0;
  connect(partialHeatSourceHP.heatPortEvaporator, evaporator.heatPort)
    annotation (Line(
      points={{-2,80},{-40,80},{-40,10},{-50,10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heatSource.heatPortCondensor, pipe_HeatPort.heatPort) annotation (
      Line(
      points={{-2,76},{-20,76},{-20,-10},{-6,-10}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(on, heatSource.on) annotation (Line(
      points={{-108,80},{-60,80},{-60,60},{8.2,60},{8.2,69.2}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,120}}), graphics), Icon(coordinateSystem(
          preserveAspectRatio=false, extent={{-100,-100},{100,120}}), graphics));
end HeatPump;
