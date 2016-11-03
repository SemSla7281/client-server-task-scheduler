#
# Task model
#
# @author [nityamvakil]
#
class Task < ActiveRecord::Base
  validates_presence_of :name, :path, :start_time, :end_time, :weekdays,
                        :status, :agent_id
  validates_uniqueness_of :name, scope: :agent_id
  validates_uniqueness_of :path, scope: :agent_id
  validates :status, inclusion: { in: TASK_STATUS_LIST, default: 'scheduled' }
  validate :validate_weekdays

  belongs_to :agent

  def weekdays=(value)
    write_attribute :weekdays, value.join(',')
  end

  def weekdays
    self[:weekdays] ? self[:weekdays].split(',') : []
  end

  def validate_weekdays
    msg = 'There are some invalid weekdays!'
    errors.add :weekdays, msg if (weekdays - WEEKDAYS).present?
  end
end
