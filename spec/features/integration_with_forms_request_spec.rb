# encoding: utf-8
require 'acceptance_helper'

context 'On the page /integration_with_forms with another form on the page that uses the helper dump_filter_parameters_as_hidden_fields' do
  describe '(on /integration_with_form) WiceGrid', type: :request, js: true do
    before :each do
      visit '/integration_with_forms'
    end

    it 'reloads the page when the value in the form is changed' do
      within '.pagination_status' do
        expect(page).to have_content('1-20 / 46')
      end

      select 'View archived tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-4 / 4')
      end

      select 'View active tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-20 / 46')
      end
    end

    it 'keeps the state of an integer filter while reloading another form' do
      fill_in('g_f_id_fr', with: 507)
      fill_in('g_f_id_to', with: 509)

      find(:css, '#g_submit_grid_icon').click

      within '.pagination_status' do
        expect(page).to have_content('1-3 / 3')
      end

      select 'View archived tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('0')
      end

      select 'View active tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-3 / 3')
      end
    end

    it 'keeps the state of a string filter while reloading another form' do
      fill_in('g_f_title_v', with: 'ed')

      find(:css, '#g_submit_grid_icon').click

      within '.pagination_status' do
        expect(page).to have_content('1-2 / 2')
      end

      select 'View archived tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('0')
      end

      select 'View active tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-2 / 2')
      end
    end

    it 'keeps the state of a string filter with negation while reloading another form' do
      fill_in('g_f_title_v', with: 'ed')
      find(:css, '#g_f_title_n').click

      find(:css, '#g_submit_grid_icon').click

      within '.pagination_status' do
        expect(page).to have_content('1-20 / 44')
      end

      select 'View archived tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-4 / 4')
      end

      select 'View active tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-20 / 44')
      end
    end

    it 'keeps the state of a custom filter with negation while reloading another form' do
      select 'Cancelled',  from: 'g_f_status_id'
      select 'Super Game', from: 'g_f_project_id'

      find(:css, '#g_submit_grid_icon').click

      within '.pagination_status' do
        expect(page).to have_content('1-4 / 4')
      end

      select 'View archived tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('0')
      end

      select 'View active tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-4 / 4')
      end
    end

    it 'keeps the state of a date filter  while reloading another form' do
      set_datepicker(self, 'g_f_due_date_fr_date_placeholder', 2023, 0, 1)

      set_datepicker(self, 'g_f_due_date_to_date_placeholder', 2025, 0, 1)

      find(:css, '#g_submit_grid_icon').click

      within '.pagination_status' do
        expect(page).to have_content('1-15 / 15')
      end

      select 'View archived tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('0')
      end

      select 'View active tasks', from: 'archived'

      within '.pagination_status' do
        expect(page).to have_content('1-15 / 15')
      end
    end
  end
end
