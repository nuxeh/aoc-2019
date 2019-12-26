use std::env;
use std::error::Error;
use std::path::PathBuf;
use std::process;

mod intcode;

use intcode::IntcodeComputer;

fn main() {
    let in_path: PathBuf = env::args().into_iter().skip(1).take(1).collect();

    let mem = intcode::read_file(&in_path).unwrap_or_else(|e| {
        eprintln!("error: {}", e);
        process::exit(1);
    });

    let mut comp = IntcodeComputer::new()
        .load_mem(mem)
        .init();

    comp.run().unwrap_or_else(|e| {
        eprintln!("error in execution: {}", e);
    });

    println!("{:?}", comp.outputs);

    println!("{:?}", find(vec![], 0, 0, &mut comp));
}

struct Point {
    x: i64,
    y: i64,
}

fn mv(mem: &[i64], path: &[i64], cmd: i64) -> Result<i64, Box<dyn Error>> {
    let mut c = IntcodeComputer::new()
        .load_mem_pad(mem)
        .init();

    for m in path {
        c.input(*m);
    }
    c.input(cmd);

    c.run()?;
    match c.outputs.pop() {
        Some(r) => Ok(r),
        None => Err("no output provided after movement command".into()),
    }
}
    
fn find(path: Vec<Point>, x: i64, y: i64, c: &mut IntcodeComputer) {
    
}
