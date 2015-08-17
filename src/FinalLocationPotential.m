function potential = FinalLocationPotential( drone_pos, final_pos )
    del = drone_pos-final_pos;
    r2 = dot(del,del);
    r = sqrt(r2);

    potential = 100*r*r;

end