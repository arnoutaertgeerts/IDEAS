within IDEAS.DistrictHeating.HeatingSystems;
package SpaceHeating
  partial model PartialSpaceHeating
    "Partial for a space heating model using Radiators"

    //Extensions
    extends IDEAS.Fluid.Interfaces.PartialTwoPortInterfaceVertical(
      m_flow_nominal=sum(m_flow_nominal_zone));

    //Parameters
    parameter Integer nZones(min=1);
    parameter Modelica.SIunits.Power[nZones] QNom(each min=0) = ones(nZones)*5000
      "Nominal power, can be seen as the max power of the emission system per zone";
    parameter Boolean minSup=true
      "true to limit the supply temperature on the lower side";
    parameter Modelica.SIunits.Temperature TSupMin=273.15 + 30
      "Minimum supply temperature if enabled";
    parameter Modelica.SIunits.Temperature TSupNom=273.15 + 45
      "Nominal supply temperature";
    parameter Modelica.SIunits.TemperatureDifference dTSupRetNom=10
      "Nominal DT in the heating system";
    parameter Modelica.SIunits.Temperature[nZones] TRoomNom={294.15 for i in 1:
        nZones} "Nominal room temperature";
    parameter Modelica.SIunits.TemperatureDifference corFac_val = 0
      "correction term for TSet of the heating curve";
    parameter Modelica.SIunits.Time timeFilter=43200
      "Time constant for the filter of ambient temperature for computation of heating curve";
    final parameter Modelica.SIunits.MassFlowRate m_flow_nominal_zone[nZones] = QNom/(4180.6*dTSupRetNom)
      "Nominal mass flow rates";

    //Components

    //--Ports
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortCon[nZones]
      "Nodes for convective heat gains"
      annotation (Placement(transformation(extent={{-30,90},{-10,110}})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortRad[nZones]
      "Nodes for radiative heat gains"
      annotation (Placement(transformation(extent={{10,90},{30,110}})));

    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPortLosses
      "Heat port for losses to the zone from the pipes"
      annotation (Placement(transformation(extent={{-10,-108},{10,-88}})));

    //--Emission System
    replaceable Fluid.HeatExchangers.Radiators.Radiator[nZones] emission(
      each TInNom=TSupNom,
      each TOutNom=TSupNom - dTSupRetNom,
      TZoneNom=TRoomNom,
      QNom=QNom,
      each powerFactor=3.37,
      redeclare each package Medium = Medium)
      constrainedby IDEAS.Fluid.HeatExchangers.Interfaces.EmissionTwoPort
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-20,0})));

    //--Pipes
    Fluid.FixedResistances.Pipe_Insulated[nZones] pipeReturnEmission(
      redeclare each package Medium = Medium,
      each m=1,
      each UA=10,
      m_flow_nominal=m_flow_nominal_zone) annotation (Placement(transformation(
          extent={{10,4},{-10,-4}},
          rotation=180,
          origin={10,0})));

    Fluid.FixedResistances.Pipe_Insulated[nZones] pipeSupply(
      redeclare package Medium = Medium,
      each m=1,
      each UA=10,
      m_flow_nominal=m_flow_nominal_zone)
      annotation (Placement(transformation(extent={{-10,-4},{10,4}},
          rotation=0,
          origin={-50,0})));

    Fluid.MixingVolumes.MixingVolume vol(
      redeclare package Medium = Medium,
      m_flow_nominal=sum(m_flow_nominal_zone),
      V=sum(m_flow_nominal)*30/1000,
      nPorts=nZones+1)
      annotation (Placement(transformation(
          extent={{-10,10},{10,-10}},
          rotation=180,
          origin={40,10})));

    //--Sensors
    Fluid.Sensors.TemperatureTwoPort senTemEm_out(
      redeclare package Medium=Medium,
      m_flow_nominal=sum(m_flow_nominal_zone))
      "Outlet temperature of the emission system" annotation (Placement(
          transformation(
          extent={{10,10},{-10,-10}},
          rotation=180,
          origin={70,0})));

    Fluid.Sensors.TemperatureTwoPort senTemEm_in(
      redeclare package Medium =
      Medium, m_flow_nominal=sum(m_flow_nominal_zone))
      "Inlet temperature of the emission system"
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-78,0})));

  equation
    // connections that are function of the number of circuits
    for i in 1:nZones loop
      connect(pipeReturnEmission[i].heatPort, heatPortLosses) annotation (
        Line(
        points={{10,-4},{10,-60},{0,-60},{0,-98}},
        color={191,0,0},
        smooth=Smooth.None));
      connect(pipeSupply[i].heatPort, heatPortLosses) annotation (Line(
        points={{-50,-4},{-50,-60},{0,-60},{0,-98}},
        color={191,0,0},
        smooth=Smooth.None));
      connect(pipeSupply[i].port_a, senTemEm_in.port_b)  annotation (Line(
        points={{-60,0},{-68,0}},
        color={0,127,255},
        smooth=Smooth.None));
    end for;

    connect(pipeSupply.port_b, emission.port_a) annotation (Line(
        points={{-40,0},{-30,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(emission.port_b, pipeReturnEmission.port_a) annotation (Line(
        points={{-10,0},{0,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senTemEm_in.port_a, port_a) annotation (Line(
        points={{-88,0},{-94,0},{-94,-80},{-60,-80},{-60,-100}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(senTemEm_out.port_b, port_b) annotation (Line(
        points={{80,0},{88,0},{88,-80},{60,-80},{60,-100}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(pipeReturnEmission.port_b, vol.ports[1:nZones]) annotation (Line(
        points={{20,0},{40,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(vol.ports[end], senTemEm_out.port_a) annotation (Line(
        points={{40,0},{60,0}},
        color={0,127,255},
        smooth=Smooth.None));
    connect(vol.heatPort, heatPortLosses) annotation (Line(
        points={{50,10},{54,10},{54,-60},{0,-60},{0,-98}},
        color={191,0,0},
        smooth=Smooth.None));
    annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics), Icon(coordinateSystem(
            preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={Line(
            points={{-60,-94},{-60,60},{-40,60},{-40,-60},{-30,-60},{-30,60},{-10,
                60},{-10,-60},{10,-60},{10,60},{30,60},{30,-60},{40,-60},{40,60}},
            color={0,0,255},
            smooth=Smooth.None), Line(
            points={{40,60},{60,60},{60,-100}},
            color={0,0,255},
            smooth=Smooth.None)}));

  end PartialSpaceHeating;
end SpaceHeating;
