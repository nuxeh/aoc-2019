use intcode::{Intcode, IntcodeComputer};

pub fn ADD(int: &Intcode, comp: &mut IntcodeComputer) -> Result<i16, Box<dyn Error>> {
    match int {
        Intcode::ADD(i, j, o) => o.set(comp, i.get(comp)? + j.get(comp)?),
        _ => ()
    };
    Ok(())
}

pub fn MULT(int: &Intcode, comp: &mut IntcodeComputer) {
}
