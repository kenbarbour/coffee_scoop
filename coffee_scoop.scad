/**
 * Covfefe Scoop
 *
 * Generates a scoop to collect the correct amount of coffee grounds
 * for a given amount of water.
 *
 * @author Kenneth Barbour <kenbarbour@gmail.com>
 * @license GPLv3
 */

// volume of water before boiling in mL
/*
Coffee brewing equipment often considers 1 cup equivalent to 180 mL (serving size),
instead of 240 mL (1 US cup).
*/
water_volume = 240 * .75; //240 mL = 1 US cup

// Ratio of coffee grounds to unboiled water (g/mL)
/*
euro standard as defined by Specialty Coffee Association of America:
7 grams per 125 ml (0.056)
*/
ratio = 0.056; // 7 grams per 125 mL = 0.056

// Thickness of scoop walls
wall_thickness = 1.5;

// Coffee ground density  (in Kg/m^3)
/*
Various coffee densities in Kg/m^3
as tested by the International Coffee Organization:

Whole Bean Light Roast: 370
Whole Bean Dark Roast: 290
Coarse Grind: 300
Fine Grind: 400
*/
coffee_density = 350;


// Configure handle and text
handle_size = [15,45,3]; // [x,y,z] dimensions of the handle
text_size = 6;
text_content = str(water_volume," mL");

// Calculate dimensions of the scoop (hemisphere of given volume)
grounds_mass = coffee_mass_by_water(water_volume, ratio);
grounds_volume = coffee_volume(grounds_mass, coffee_convert_density(coffee_density));
// grounds_volume = coffee_volume(grounds_mass, grounds_density); // uncomment if using g/mm^3 density
inner_radius = pow(grounds_volume*2 / (4/3) / 3.1416, 1/3);

// Report aforementioned calculations
echo(str("Volume of brewed coffee: ", water_volume, " mL"));
echo(str("Amount of grounds:       ", grounds_mass, " grams"));
echo(str("Volume of grounds:       ", grounds_volume, " mm^3"));

// Quality
$fn = 64;

// Generate a scoop with a label
difference() {
    
    covfefe_scoop(inner_radius, handle_size, wall_thickness);


    translate([text_size/-2,inner_radius+2*wall_thickness,-.001])
    rotate([0,0,-90])
    mirror([1,0,0])
    linear_extrude(1) {
        text(text_content, size=text_size);
    }
}

module covfefe_scoop(inner_radius, handle_size, wall_thickness = 3)
{
    outer_radius = inner_radius + wall_thickness;
    union() { // hollow hemisphere with handle
        intersection() { // hollow hemisphere
            difference() {  // hollow sphere
                sphere(r=outer_radius);
                sphere(r=inner_radius);
            }
            cylinder(r=outer_radius,h=outer_radius+1);
        }
        if (handle_size != undef && handle_size != 0) {
            covfefe_scoop_handle(handle_size,inner_radius);
        }
    }
}

module covfefe_scoop_handle(size,offset)
{
    translate([size[0]/-2,offset,0])
    cube([size[0],size[1]-size[0]/2,size[2]]);
    translate([0, offset + size[1] - size[0]/2,0])
        cylinder(r=size[0]/2,h=size[2]);
}

function coffee_mass_by_water(milliliters, ratio) = ratio * milliliters;

/**
 * Volume of coffee grounds occupied by given mass of coffee grounds with given density
 * @param mass: mass in grams of coffee grounds
 * @param density: density of coffee grounds in grams per cubic mm
 */
function coffee_volume(mass, density) = mass / density;

/**
 * Convert Kg/m^3 density as often reported by whoever measures coffee into g/mm^3
 */
function coffee_convert_density(kg_per_cubic_meter) = kg_per_cubic_meter / 1000000;