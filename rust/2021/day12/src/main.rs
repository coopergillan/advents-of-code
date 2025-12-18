// Advent of Code solver

// use std::cmp::Ordering;
// use std::collections::BinaryHeap;
use std::collections::HashMap;
use std::fs;

#[derive(Debug, PartialEq)]
struct TopLevelStructOneStringPerLine {
    // Accept the input as one attribute - use isize if negative numbers needed
    // For one value per line use a vector of integers
    input_data: Vec<String>,
}

impl TopLevelStructOneStringPerLine {
    // For one value per line use a vector of integers
    fn new(input_data: Vec<String>) -> Self {
        TopLevelStructOneStringPerLine { input_data }
    }

    fn from_file(file_path: &str) -> Self {
        // For reading each line into an array
        let raw_content = fs::read_to_string(file_path).expect("Unable to read file");
        dbg!(&raw_content);

        // Process the content - for example change number in each line to an integer
        let raw_content_lines = raw_content.lines();
        let processed_content = raw_content_lines.map(|line| line.to_string()).collect();
        Self::new(processed_content)
    }

    fn process_data(&self) -> HashMap<&str, Vec<&str>> {
        let mut processed_data = HashMap::<&str, Vec<&str>>::new();

        for mapping in &self.input_data {
            // dbg!(&mapping);
            let (key, value) = mapping.split_once("-").expect("Couldn't unpack");
            // dbg!(&key, &value);
            processed_data.entry(key).or_insert(Vec::new()).push(value);
        }

        dbg!(&processed_data);
        processed_data
    }

    fn visit_cave(mapping: HashMap<&str, Vec<&str>, start: &'a str, visited: Vec<&str>) -> Vec<&'a str> {
        let mut queue = VecDeque::new();
        queue.push_back(start);

        while let Some(cave) = queue.pop_front
    }

    fn part1(&self) -> usize {
        let mapping = self.process_data();

        let mut queue = VecDeque::new();


    }
}

// #[derive(Copy, Clone, Debug, Eq, PartialEq)]
// struct Edge {
//     node: &str,
//     cost: usize,
// }

fn main() {
    println!("Hello world");
    let input_file = "test_input_small.txt";

    let raw_content = fs::read_to_string(input_file).unwrap();
    dbg!(&raw_content);

    // let top_level = TopLevelStructOneStringPerLine::from_file(input_file);
    // dbg!(&top_level);
    // dbg!(&top_level.process_data());

    // println!("Part 1 answer: {}", top_level.solve_part1());
    // println!("Part 2 answer: {}", top_level.solve_part2());
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_one_string_per_line_to_map() {
        let top_level = TopLevelStructOneStringPerLine::from_file("test_input_small.txt");
        assert_eq!(
            top_level.process_data(),
            HashMap::from([
                ("start", vec!["A", "b"]),
                ("A", vec!["c", "b", "end"]),
                ("b", vec!["d", "end"]),
            ])
        );
    }

    #[test]
    fn test_part_one() {
        let top_level = TopLevelStructOneStringPerLine::from_file("test_input_small.txt");
        assert_eq!(top_level.part1(), 10);
    }
}
