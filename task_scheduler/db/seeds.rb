agents = Agent.create!(
  [
    { secret_key: 'first', decode_key: 'first' }
  ]
)

[
  {
    name: 'Task1',
    path: 'crossover/dummy_tasks/task1.sh',
    arguments: nil,
    start_time: Time.now + 1.minute,
    end_time: Time.now + 1.day,
    weekdays: WEEKDAYS,
    agent_id: agents.first.id
  },
  {
    name: 'Task2',
    path: 'crossover/dummy_tasks/task2_with_arguments.sh',
    arguments: 'a1',
    start_time: Time.now + 1.minute,
    end_time: Time.now + 1.day,
    weekdays: WEEKDAYS,
    agent_id: agents.first.id
  },
  {
    name: 'Task3',
    path: 'crossover/dummy_tasks/adasd.sh',
    arguments: 'a1',
    start_time: Time.now + 1.minute,
    end_time: Time.now + 1.day,
    weekdays: WEEKDAYS,
    agent_id: agents.first.id
  },
  {
    name: 'Task4',
    path: 'crossover/dummy_tasks/xxxx.sh',
    arguments: 'a1',
    start_time: Time.now + 2.days,
    end_time: Time.now + 3.days,
    weekdays: WEEKDAYS,
    agent_id: agents.first.id
  }
].each { |task| Tasks::Crud.new(task).create }
