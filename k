/*--------------------------------*- C++ -*----------------------------------*\
| =========                 |                                                 |
| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |
|  \\    /   O peration     | Version:  v2012                                 |
|   \\  /    A nd           | Website:  www.openfoam.com                      |
|    \\/     M anipulation  |                                                 |
\*---------------------------------------------------------------------------*/
FoamFile
{
    version     2.0;
    format      ascii;
    class       volScalarField;
    location    "0";
    object      k;
}
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

dimensions      [0 2 -2 0 0 0 0];

//internalField   uniform 0.000171735;
internalField   uniform 0.00008;	// Tu=0.1%, TuL=0.002m

boundaryField
{
    inlet
    {
        type            fixedValue;
        value           $internalField;
    }
    outlet
    {
        type            zeroGradient;
    }
    cylinder
    {
        type	        kqRWallFunction;
        //type            fixedValue;
        value           $internalField;
    }
    "(top|bottom)"
    {
        type            symmetry;
    }
    
    frontAndBack
    {
        type            symmetry;
    }
}

// ************************************************************************* //
