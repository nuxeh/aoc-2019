use std::env;
use std::process;
use std::path::PathBuf;

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

fn move(c: &mut IntcodeComputer, cmd: i64) {
    c.input(cmd);
    c.run().unwrap_or_else(|e| {
        println!("err: {}", e);
        process::exit(1);
    });
    if 

fn find(path: Vec<Point>, x: i64, y: i64, c: &mut IntcodeComputer) {
    if c.input(1)
}
