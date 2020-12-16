//Create the particle systems
globalvar particleSystem;
particleSystem = part_system_create();

globalvar particlePlatSystem;
particlePlatSystem = part_system_create();


//Create the particle types
globalvar pBlood; //Blood
pBlood = part_type_create();
part_type_sprite(pBlood, sPixel, false, false, false);
part_type_color1(pBlood, c_red);
part_type_direction(pBlood, 0, 360, 0, 16);
part_type_speed(pBlood, 0.5, 1.6, -0.8, -4);
part_type_life(pBlood, 3, 25);

globalvar pDeath; //Death
pDeath = part_type_create();
part_type_sprite(pDeath, sPixel, false, false, false);
part_type_color1(pDeath, c_red,);
part_type_direction(pDeath, 0, 360, 0, 16);
part_type_speed(pDeath, 3, 7, -0.3, -3);
part_type_life(pDeath, 5, 40);